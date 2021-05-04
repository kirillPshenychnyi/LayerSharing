#ifndef CA_LAYERS_REMOTE_LAYER_API
#define CA_LAYERS_REMOTE_LAYER_API

#import <Cocoa/Cocoa.h>

// The CGSConnectionID is used to create the CAContext in the process that is
// going to share the CALayers that it is rendering to another process to
// display
extern "C" {
typedef uint32_t CGSConnectionID;
CGSConnectionID CGSMainConnectionID(void);
};

// The CAContextID type identifies a CAContext across processes. This is the
// token that is passed from the process that is sharing the CALayer that it is
// rendering to the process that will be displaying that CALayer
typedef uint32_t CAContextID;

// The CAContext has a static CAContextID which can be sent to another process.
// When a CALayerHost is created using that CAContextID in another process, the
// content displayed by that CALayerHost will be the content of the CALayer
// that is set as the |layer| property on the CAContext
@interface CAContext : NSObject
  + (id)contextWithCGSConnection:(CAContextID)contextId options:(NSDictionary*)optionsDict;
  @property(readonly) CAContextID contextId;
  @property(retain) CALayer *layer;
@end

// The CALayerHost is created in the process that will display the content
// being rendered by another process. Setting the |contextId| property on
// an object of this class will make this layer display the content of the
// CALayer that is set to the CAContext with that CAContextID in the layer
// sharing process
@interface CALayerHost : CALayer
  @property CAContextID contextId;
@end

#endif // CA_LAYERS_REMOTE_LAYER_API