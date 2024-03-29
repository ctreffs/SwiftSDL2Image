import XCTest
@testable import SDL2Image

final class SDL2ImageTests: XCTestCase {
    func testVersion() {

        let version = IMG_Linked_Version().pointee

        XCTAssertNotNil(version)
        XCTAssertEqual(version.major, 2)
        XCTAssertEqual(version.minor, 0)
        XCTAssertGreaterThanOrEqual(version.patch, 5)

        XCTAssertEqual(SDL_IMAGE_MAJOR_VERSION, 2)
        XCTAssertEqual(SDL_IMAGE_MINOR_VERSION, 0)
        XCTAssertGreaterThanOrEqual(SDL_IMAGE_PATCHLEVEL, 5)

    }

    func testInit() {
        let flags = Int32(IMG_INIT_JPG.rawValue | IMG_INIT_PNG.rawValue | IMG_INIT_TIF.rawValue | IMG_INIT_WEBP.rawValue)
        let initted = IMG_Init(flags)
        if (initted & flags) != flags {
            XCTFail("Initialization failed \(String(cString: SDL_GetError()))")
        }
        IMG_Quit()
    }

    func testLoad() throws {
        let logoPng = try Resource.load(.logo_png)
        guard let surfacePtr = IMG_Load(logoPng.path) else {
            XCTFail("\(String(cString: SDL_GetError()))")
            return
        }

        SDL_LockSurface(surfacePtr)
        defer {
            SDL_UnlockSurface(surfacePtr)
            SDL_FreeSurface(surfacePtr)
        }

        // https://sdl.beuc.net/sdl.wiki/Pixel_Access

        let surface = surfacePtr.pointee

        XCTAssertNotEqual(SDL_BYTEORDER, BIG_ENDIAN)
        XCTAssertEqual(SDL_BYTEORDER, LITTLE_ENDIAN)

        XCTAssertEqual(surface.w, 426)
        XCTAssertEqual(surface.h, 426)
        XCTAssertEqual(surface.format.pointee.BytesPerPixel, 4)
        XCTAssertEqual(surface.getPixelRGBA(x: 240, y: 80), [34, 34, 34, 255])
        XCTAssertEqual(surface.getPixelRGBA(x: 200, y: 300), [245, 166, 35, 255])
    }

    func testFormatEnumAvailablility() {
        XCTAssertNotNil(SDL_PIXELFORMAT_BGRA32)
        XCTAssertNotNil(SDL_PixelFormatEnum(SDL_PIXELFORMAT_BGRA32.rawValue))
    }

}
