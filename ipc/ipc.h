#ifndef CA_LAYERS_IPC_H
#define CA_LAYERS_IPC_H

#include <stdio.h>
#import <Cocoa/Cocoa.h>

namespace ipc {
class Ipc {
  struct IpcData {
    int is_parent;
    pid_t child_pid;
    int parent_read_fd;
    int parent_write_fd;
    int child_read_fd;
    int child_write_fd;
  };

  Ipc() = default;

public:
  static Ipc& instance();

  ~Ipc() = default;

  void terminate();

  int fork_process();
  // Blocking read_data from the other process
  template <typename T> void read_data(T *t);

  template <typename T> void write_data(const T *t);

private:
  void kill_child();
  void close_fds();

private:
  IpcData data_{0};
  int pipe_fds_[2];
};

}

#endif // CA_LAYERS_IPC_H
