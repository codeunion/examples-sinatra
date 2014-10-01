# Public File Upload

This example Sinatra application implements a basic photo gallery to demonstrate how file uploading and processing works.

Rather than storing the files in the `public` directory, this application integrates with [Amazon's Simple Storage Service](http://aws.amazon.com/s3/) (aka Amazon S3).  This application will need information about your Amazon Web Services (AWS) account in order to upload files successfully.  See below for how to do this.

## Running The Application

Make sure you're in the `public-file-upload` directory.  Once there, run the following two commands to configure your application correctly:

```text
$ bundle install --without production
$ rake setup:dotenv
```

### Configuring AWS

Before we can run our application, we need to set up our Amazon Web Services (aka AWS) account.  AWS encompasses dozens of Amazon "cloud services," including Amazon's Simple Storage Service (aka S3), which is where we'll be sending our user-uploaded images.  This is necessary on services like Heroku which don't allow us to save user-uploaded files directly in our web application's `public` directory.

To use Amazon's Simple Storage Service (aka S3), you'll first need to create an AWS account.

1.  Sign up for [Amazon AWS](http://aws.amazon.com/).

    When you've successfully signed up, you'll see what's called the _AWS Management Console_ — a big list of Amazon services you can sign up for.
1.  Once you've signed up, we need to create what Amazon calls _Access Keys_ in order to interact with AWS programmatically.

    To do this, click on your account name in the upper right-hand corner.  A dropdown should appear which contains a link to the [Security Credentials](https://console.aws.amazon.com/iam/home?#security_credential) page.
1.  On the [security credentials page](https://console.aws.amazon.com/iam/home?#security_credential), click the _Access Keys_ section.  You should see a button labeled _Create New Access Key_.  When you click this button you should see a small popup that contains two pieces of information: an _Access Key ID_ and a _Secret Access Key_.

    These act as a kind of username/password combination for your AWS account, so don't publish them anywhere public!
1.  Inside the `.env` file, edit the lines that read

    ```text
    AWS_ACCESS_KEY_ID="fill-me-in"
    AWS_SECRET_ACCESS_KEY="fill-me-in"
    ```

    and replace `"fill-me-in"` with the _Access Key ID_ and _Secret Access Key_ that Amazon gave you.  Here are two _example_ values, so you can see what they look like.

    ```text
    # These are just examples and won't actually work. Use the values
    # that Amazon gave you.
    AWS_ACCESS_KEY_ID="AKIAIBU4G7ZPNSEXSVFQ"
    AWS_SECRET_ACCESS_KEY="Pg+j/VKlpSENGyEOidEKHHQ3Ox9Nxs0T35VcyCAK"
    ```

This Access Key ID and Secret Access Key will allow us to interact with _any_ Amazon web service, including S3.

### Configuring S3

Now that we have an AWS account, we need to enable and configure Amazon's Simple Storage Service (aka S3) for our account.

1.  Navigate to the [Amazon S3 section](https://console.aws.amazon.com/s3/) in the Management Console.
1.  Create a new bucket by clicking the _Create Bucket_ button.

    *Note*: This name has to be unique across _all_ bucket names on S3, so pick something likely to be unique, e.g., `myname-s3-upload-demo`.
1.   In your `.env` file, replace

    ```text
    AWS_S3_BUCKET_NAME="fill-me-in"
    ```

    with the actual name of your S3 bucket.  For exampe,

    ```text
    # This is just an example - use your own bucket name.
    AWS_S3_BUCKET_NAME="myname-s3-upload-demo"
    ```
1.  By default, any file you upload to S3 will be available at <https://my-bucket-name.s3.amazonaws.com/example-file.jpg>.

    We'll need this host name — called the _asset host_ — so that we can link to the correct image.  The `.env` file is set up to work this way out of the box so long as you correctly set the `AWS_S3_BUCKET_NAME` environmenet variable.

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
