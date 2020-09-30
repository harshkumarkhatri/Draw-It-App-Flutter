# draw_it_app

A new Flutter project.
to be done:-
* Saving the canvas and clearing the screen---done
* deleting the lines which we have drawn--- ased an erase option.
* adding a background image on which drawing can be done and then saving it.
* adding some text on the image---not doing this for now.
* make the drawing screen with the app bar so that some details can be added in the appbar----Done with a stack
* adding double back to close the app--- this is not being done as we are having a snackbar pre present in the bottom and it will not appear again
* saving to the device is working fine. i need to add a ticker which can be used to save the photos to the gallery or to the cloud.Was working on this look for how we can save the state of the variable defined in the del_variable and changed with the ticker.---added an option in the top 3 dots which can be used to switch between the saving state.
* the only pro3blem which is coming now is that the screen is not refreshed after th image is save to gallery whereas when the image is saved to cloud things are fine.---Added it to FAQ.
* Saving images to storage in a particular folder--- done with the help of keeping a new directory name along with the file.
* Saving images to cloud in the folder which is unique and identified with their username/email--- Done by adding a folderName/to the file name.
* Completed the UI for login app
* Completed the login page functionalities:-agar sign in kr k jayega toh ander feature us hisab sai milenge. agar skip for now kr k jayega toh ander feature us hisaab sai milenge.
* Completed circular progress bar indicator thing for login page.
* App is saving the login if the user logs in once.
* If the user does not logs in then he has to log in again and again.
* Replace logout with profile option and in that display logout option.---not doing this because we do not have many things to show in profile except for emamil.
* Adding the login and signup if the user wished to save to the cloud. This condition of login should be satisfied first. Also once the login is made then the app saves the login and it should not be done each time the app is closed.
* clearing the textfields in sign upp after unsuccessful sign up.---added
* make the password text fields obscure in all the text fields.---done
* Add a circular progress bar indication when the user is submitting the form to make it look that it is taking time like naturally.---added for both the pages.
* Saving the user login permanently so there is no need to login again and again and showing the logged in user details inside the user section(to be developed). Display please login if user is not logged in.---saving the user login permanently id done, usersection is not developing because there is only email to display in it. An alternate to this is done where we show logout to user after he has login saved else we show login.

* If possible add login from google account and from other accounts as well.
* confirm password is not working
* push and context need to seen.As if we click on login after we have skipped first, it takes us to login but if we click in back button it takes us to screen. check if loggin in and clicking back takes us there.
* Replace thefolder name with the username after successful login.
* A way with whcih the images which are displayed from the cloud can be opened in the gallery.
* A waythrough which we can display all the images from the cloud and from storage to the user in another screen.
* Add a screen to display all the images which are saved in the cloud.(will be done once we are able to figure out how to save multiple values in firebase key value pair)
* Store email and the image links to the
database(2 cols). Update the links each
time a new image uploaded, To  show the
images check if we have the email same
as that in sprefs.
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:
****
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
