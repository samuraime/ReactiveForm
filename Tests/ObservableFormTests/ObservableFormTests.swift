import XCTest
import ObservableForm

class ProfileForm: ObservableForm {
  @FormField(validators: [.required])
  var name: String = ""
  
  @FormField(validators: [.required, .email])
  var email: String = ""
}

class SettingForm: ObservableForm {
  var name = FormControl("", validators: [.required])
  var email = FormControl("", validators: [.required, .email])
}

final class ObservableFormTests: XCTestCase {
  func testFormField() throws {
    let profileForm = ProfileForm()

    XCTAssertFalse(profileForm.$email.isValid)
    XCTAssertTrue(profileForm.$email.errors[.email])
    
    profileForm.$email.value = "test"
    
    XCTAssertFalse(profileForm.$email.isValid)
    XCTAssertTrue(profileForm.$email.errors[.email])

    profileForm.$email.value = "test@gmail.com"

    XCTAssertTrue(profileForm.$email.isValid)
    XCTAssertFalse(profileForm.$email.errors[.email])
  }

  func testFormControl() throws {
    let settingForm = SettingForm()

    XCTAssertFalse(settingForm.email.isValid)
    XCTAssertTrue(settingForm.email.errors[.email])

    settingForm.email.value = "test"

    XCTAssertFalse(settingForm.email.isValid)
    XCTAssertTrue(settingForm.email.errors[.email])

    settingForm.email.value = "test@gmail.com"

    XCTAssertTrue(settingForm.email.isValid)
    XCTAssertFalse(settingForm.email.errors[.email])
  }
}
