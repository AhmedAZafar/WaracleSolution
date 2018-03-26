Following are the steps that I didn't do but would prefer to:-

1. If allowed, setup Carthage & use AlamoFire & AlamoFireImage for downloading data & images.

2. If third party libraries are not allowed, create a Static Library called 'CakeWebService' with CakeDataService & CakeImageService classes that provide methods for specific requests. The classes woould be implemented as Singletons and view controllers would be able to use the singleton by conforming to CakeDataServiceProtocol & CakeImageServiceProtocol. This is to make the code base more modular.

3. Implement Unit tests & xctests

4. Prefer to write all this in Swift using Protocol Oriented Programming following MVVM design pattern with FRP.
