# CommonButton Specifications

### Purpose
To abstract the basic use cases for UIButton.
We generally don't use UIButton without configuring the button in some way.
 
##### Common UIButton configurations:
- clipping corners
- rounding corners 
- customizing border (width and color)
- adding activity indicator
- disabling interaction when activity indicator is on
- dimming color when highlighted and disabled
- adds an action closure (for touchUpInside event)
- extend button touch margin

##### What type of features should CommonButton have ? 
The most common and basic features. 
This will accomplish two things. It will prevent the framework from getting out of hand with unnecessary and uncommon features. It will also help prevent the usage of 3rd party frameworks.

--

### Feature Details 

> Difference between **clipped corners** and **round corners**. 
A clipped button will be mostly squared but will have a slight rounded tip. A rounded corner will have fully rounded corners. These are the two main type of corner styles that you will encounter on mainstream apps. 

---

> **Corner customization** should be self explanatory.

___

> **Disabling interaction** when **activity indicator** is shown will prevent users from pressing a button more than once while an action is being processed. For example, if a login button is pressed multiple times multiple login actions will be sent. Ideally button interactions should be disabled while the activity indicator is shown.

---

> Button's should be automatically **dimmed** when selected and disabled. Button's background color is not dimmed automatically.

---

> An **action closure** is called when the touch-up-inside action is triggered. This is generally added because we need to pass in an index or other information to the touch action, target action does not let us do this. Imagine that you have a cell with a button and want to perform an action that involves the `indexPath` of the current cell. We can pass in the `indexPath` to the button's action closure. Target action does not let us do this.

---

> We generally **extend the button's touch margin** when the button is so small that it's difficult for a user to touch the button correctly. Extending the button touch rect fixes this issue.

