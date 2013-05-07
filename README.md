# IGAutoString

Convert string in arbitary encoding to NSString in Objective-C. 

## Usage

```objective-c
NSString* string = [IGAutoString stringWithData:data];
```

```data``` can be NSData encoded in any encoding.

## Installation

If you use CocoaPods, add following line to your Podfile:

```
pod ' IGAutoString'
```

Otherwise, add ```IGAutoString/IGAutoString.*```, as well as [UniversalDetector](https://github.com/siuying/UniversalDetector) to your project.

## Dependencies

- [UniversalDetector](https://github.com/siuying/UniversalDetector)

## License

MIT License. See LICENSE.

