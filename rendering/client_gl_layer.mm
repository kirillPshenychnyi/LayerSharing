#define GL_SILENCE_DEPRECATION

#import "client_gl_layer.h"

#import <OpenGL/glu.h>

@implementation ClientGlLayer
  GLfloat phi_;
  GLfloat theta_;

- (id)init {
    if (self = [super init]) {
       phi_ = 0;
       theta_ = 0;
    }
    return self;
}

- (void)drawInCGLContext:(CGLContextObj)glContext
    pixelFormat:(CGLPixelFormatObj)pixelFormat
    forLayerTime:(CFTimeInterval)timeInterval
    displayTime:(const CVTimeStamp *)timeStamp {
      GLfloat grey = 0.05f;
      glClearColor(grey, grey, grey, 1);
      glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

      glMatrixMode(GL_PROJECTION);
      glLoadIdentity();
      gluPerspective(45, 1, 0.1, 1000);

      glMatrixMode(GL_MODELVIEW);
      glLoadIdentity();
      glTranslatef(0, 0, -10);

      phi_ += 1;
      theta_ += 2;

      glRotatef(phi_, 1, 0, 0);
      glRotatef(theta_, 0, 1, 0);

      glLineWidth(4);
      glBegin(GL_LINES);
      glColor3f(1, 0, 0); glVertex3f(0, 0, 0); glVertex3f(1, 0, 0);
      glColor3f(0, 1, 0); glVertex3f(0, 0, 0); glVertex3f(0, 1, 0);
      glColor3f(0, 0, 1); glVertex3f(0, 0, 0); glVertex3f(0, 0, 1);
      glEnd();

      glColor3f(0, 0, 0);
}

@end
