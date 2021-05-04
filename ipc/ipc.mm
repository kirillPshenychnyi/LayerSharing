#include "ipc.h"
#include "rendering/remote_layer_api.h"
#import <Cocoa/Cocoa.h>

namespace ipc {

#define CHECK(x) \
  if (!(x)) { \
    fprintf(stderr, "Check %s failed at %s:%d\n", #x, __FILE__, __LINE__); \
    exit(1); \
  } \


Ipc& Ipc::instance() {
  static Ipc ipc;
  return ipc;
}

void Ipc::terminate() {
  kill_child();
  close_fds();
}

int Ipc::fork_process() {
  int pipe_result;
  pipe_result = pipe(pipe_fds_);
  CHECK(pipe_result == 0);
  data_.child_read_fd = pipe_fds_[0];
  data_.parent_write_fd = pipe_fds_[1];
  pipe_result = pipe(pipe_fds_);
  CHECK(pipe_result == 0);
  data_.parent_read_fd = pipe_fds_[0];
  data_.child_write_fd = pipe_fds_[1];

  data_.child_pid = fork();
  data_.is_parent = data_.child_pid != 0;
  return data_.is_parent;
}

template <typename T> void Ipc::read_data(T *t) {
  int fd = data_.is_parent ?
           data_.parent_read_fd : data_.child_read_fd;
  size_t bytes_read = read(fd, t, sizeof(T));
  CHECK(bytes_read == sizeof(T));
}

template <typename T> void Ipc::write_data(const T *t) {
  int fd = data_.is_parent ? data_.parent_write_fd : data_.child_write_fd;
  size_t bytes_written = write(fd, t, sizeof(T));
  CHECK(bytes_written == sizeof(T));
}

void Ipc::kill_child() {
  CHECK(data_.child_pid);
  kill(data_.child_pid, SIGTERM);
}

void Ipc::close_fds() {
  close(pipe_fds_[0]);
  close(pipe_fds_[1]);
}

template void Ipc::read_data<CAContextID>(CAContextID *);
template void Ipc::write_data<CAContextID>(const CAContextID *);

}