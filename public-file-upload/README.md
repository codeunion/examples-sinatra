# Public File Upload

This example Sinatra application implements a basic photo gallery to demonstrate how file uploading and processing works.

This application saves the files in the `public/photos` directory, which means it won't work on Heroku since Heroku has a read-only file system.  In that environment, you would need to save photos to S3 or a similar third-party hosting service.

## Running The Application

Make sure you're in the `public-file-upload` directory.  Once there, run the following two commands to configure your application correctly:

```text
$ bundle install --without production
$ rake setup:dotenv
```

### On Cloud9

If you're using [Cloud9](http://c9.io), run the application with

```
$ ruby app.rb -p $PORT -o $IP
```

### On Your Own Computer

If you're on your own computer, run the application with

```
$ ruby app.rb
```

If everything runs successfully, you should be able to visit <http://localhost:4567> and see the web application.
