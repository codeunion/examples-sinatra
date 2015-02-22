# Examples: Sinatra

This repository will contain examples of common web development patterns
implemented with the Sinatra framework.

## Current Examples

### [User Authentication](authentication)

The `authentication` directory contains an example Sinatra application that implements basic user authentication, i.e., signing up, logging in, and logging out.

### [Public File Upload](public-file-upload)

The `public-file-upload` directory contains an example Sinatra application that implements a basic photo gallery to demonstrate how file uploading and manipulation works.  It saves the files in the `public/photos` directory, which means it won't work on Heroku since Heroku has a read-only file system.

In that environment, you would need to save photos to _Amazon's Simple Storage Service_ (aka S3) or a similar third-party hosting service.

### [S3 File Upload](s3-file-upload)

Like the **Public File Upload** example, this Sinatra application implements a basic photo gallery.  It's located in the `s3-file-upload` directory.

However, rather than saving the files to the `public/photos` directory, this application processes user uploads and then sends them up to _Amazon's Simple Storage Service_ (aka S3).  This is necessary on services like Heroku which have a read-only file system.

You will have to sign up for an [Amazon Web Services (AWS) account](https://aws.amazon.com) in order to do this.

### [Flash Messages](flash-messages)

The `flash-messages` directory contains an example Sinatra application that implements a common feature in web applications: displaying a temporary message about the results of a previous HTTP request.

For example, if you try to login but enter the wrong password, you could use a "flash" to display an error message after redirecting to the login page.

This application uses a custom implementation of a "flash" behavior on top of [Sinatra's `session` feature](http://www.sinatrarb.com/intro.html#Using%20Sessions). It is inspired by the [rack-flash](https://github.com/treeder/rack-flash) and Rails' [ActionDispatch::Flash](http://api.rubyonrails.org/classes/ActionDispatch/Flash.html).

### Facebook Login (Coming Soon)

### Sending Email (Coming Soon)

### Background Processes (Coming Soon)
