# IGAutoUnicode

Convert string in arbitary encoding to NSString in Objective-C. 

## Usage

```objective-c
NSString* string = [IGAutoUnicode stringWithData:data];
```

```data``` can be NSData encoded in any encoding.

## Installation

If you use CocoaPods, add following line to your Podfile:

```
pod 'IGAutoUnicode'
```

Otherwise, add ```IGAutoUnicode/IGAutoUnicode.*```, as well as [UniversalDetector](https://github.com/siuying/UniversalDetector) to your project.

## Dependencies

- [UniversalDetector](https://github.com/siuying/UniversalDetector)

## License

MIT License. See LICENSE.

