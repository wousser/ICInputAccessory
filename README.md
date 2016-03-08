# ICInputAccessory

A customized input accessory UI to dismiss keyboard.

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/polydice/ICInputAccessory.svg?branch=develop)](https://travis-ci.org/polydice/ICInputAccessory)

## Installation

### Install via [Carthage](https://github.com/Carthage/Carthage)

* Create a `Cartfile` with the following specification and run `carthage update`.

  ```
  github "polydice/ICInputAccessory"
  ```

* On your application targets' **General** settings tab, in the **Linked Frameworks and Libraries** section, drag and drop `ICInputAccessory.framework` from the Carthage/Build directory.

* On your application targets’ **Build Phases** settings tab, click the **+** icon and choose **New Run Script Phase**. Create a Run Script with the following contents:

  ```
  /usr/local/bin/carthage copy-frameworks
  ```

  and add the following path to **Input Files**:

  ```
  $(SRCROOT)/Carthage/Build/iOS/ICInputAccessory.framework
  ```

* For more information, please check out the [Carthage Documentation](https://github.com/Carthage/Carthage#if-youre-building-for-ios).
