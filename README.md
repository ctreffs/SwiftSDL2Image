# SwiftSDLImage

A description of this package.

<https://www.libsdl.org/projects/SDL_image/docs/SDL_image.html>


### macOS
```sh
 pkg-config --libs --cflags sdl2_image
-D_THREAD_SAFE -I/usr/local/include/SDL2 -L/usr/local/lib -lSDL2_image -lSDL2

```

### Linux
```sh
pkg-config SDL2_image --libs --cflags
-D_REENTRANT -I/usr/include/SDL2 -lSDL2_image -lSDL2
```
