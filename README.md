# ReactiveForm

[![Main workflow](https://github.com/samuraime/ReactiveForm/workflows/Main/badge.svg)](https://github.com/samuraime/ReactiveForm/actions/workflows/main.yml) [![codecov](https://codecov.io/gh/samuraime/ReactiveForm/branch/main/graph/badge.svg?token=0X34NQ63HK)](https://codecov.io/gh/samuraime/ReactiveForm)

A reactive form that build for `SwiftUI`. This library inspired by [Reactive forms of Angular](https://angular.io/guide/reactive-forms).

## Installation

- [**Swift Package Manager**](https://swift.org/package-manager/)

1. In Xcode, open your project and navigate to **File** → **Swift Packages** → **Add Package Dependency...**
2. Paste the repository URL (`https://github.com/hollyoops/ReactiveForm.git`) and click **Next**.
3. For **Rules**, select **Branch** (with branch set to `master`).
4. Click **Finish**.

- [**CocoaPods**](https://cocoapods.org) 

RecoilSwift is available through CocoaPods. To install it, simply add the following line to your Podfile:

```ruby
pod 'ReactiveForm'
```

## Basic Usage

### Define fields with property wrapper

```swift
import SwiftUI
import ReactiveForm

class ProfileForm: ObservableForm {
  @FormField(validators: [.required])
  var name = ""
  
  @FormField(validators: [.required, .email])
  var email = ""
}

struct ContentView: View {
  @StateObject var form = ProfileForm()

  var body: some View {
    Form {
      TextField("Name", text: $form.firstName)
      if form.$name.errors[.required] {
        Text("Please fill a name.")
          .foregroundColor(.red)
      }
      TextField("Email", text: $form.email)
      if form.$email.errors[.email] {
        Text("Please fill a valid email")
          .foregroundColor(.red)
      }
    }
  }
}
```

### Creating a form model

You are are not a big fan of property wrapper, you can build a form using ``ObservableForm`` and ``FormControl``.

```swift
import ReactiveForm

class ProfileForm: ObservableForm {
  var name = FormControl("", validators: [.required])
  var email = FormControl("", validators: [.required, .email])
}
```

### Working with SwiftUI

```swift
import SwiftUI

struct ContentView: View {
  @StateObject var form = ProfileForm()

  var body: some View {
    Form {
      TextField("Name", text: $form.name.value)
      if form.name.isDirty && form.name.errors[.required] {
        Text("Please fill a name.")
          .foregroundColor(.red)
      }
      TextField("Email", text: $form.email.value)
      if form.email.isDirty && form.email.errors[.email] {
        Text("Please fill a valid email.")
          .foregroundColor(.red)
      }
      Button(action: submit) {
        Text("Submit")
      }
      .disabled(form.isInvalid)
    }
  }

  func submit() {
    print(form)
  }
}
```

### Validating manually

You might think that performing validation every time the value changes is a bit too frequent. You can also perform validation manually at different times, such as `blur` of a text field or `submit` of a form.

Here is an example for validating on submit. 

It binds `pendingValue` of a form control to `TextField` instead of `value` and performs `updateValueAndValidity` on submit.

```swift
import SwiftUI

struct ContentView: View {
  @StateObject var form = ProfileForm()

  var body: some View {
    Form {
      TextField("Name", text: $form.name.pendingValue)
      if form.name.errors[.required] {
        Text("Please fill a name.")
          .foregroundColor(.red)
      }
      TextField("Email", text: $form.email.pendingValue)
      if form.email.errors[.email] {
        Text("Please fill a valid email.")
          .foregroundColor(.red)
      }
      Button(action: submit) {
        Text("Submit")
      }
    }
  }

  func submit() {
    form.updateValueAndValidity()
    if form.isValid {
      print(form)
    }
  }
}
```


## Documentation

[![Netlify Status](https://api.netlify.com/api/v1/badges/6f9d1a6b-50a6-49d6-91c9-8f842ce8e853/deploy-status)](https://app.netlify.com/sites/sad-liskov-2a1cd8/deploys)

The APIs are written by [DocC](https://developer.apple.com/documentation/docc), you can build it in your Xcode or see [the online version](https://sad-liskov-2a1cd8.netlify.app/documentation/).

## License

[MIT](LICENSE)
