# Examples: Sinatra

This repository will contain examples of common web development patterns
implemented with the Sinatra framework.

## Current Examples

### [User Authentication](authentication)

The `authentication` directory contains an example Sinatra application that implements basic user authentication, i.e., signing up, logging in, and logging out.

### [Public File Upload](public-file-upload)

The `public-file-upload` directory contains an example Sinatra application that implements a basic photo gallery to demonstrate how file uploading and manipulation works.  It saves the files in the `public/photos` directory, which means it won't work on Heroku since Heroku has a read-only file system.

In that environment, you would need to save photos to S3 or a similar third-party hosting service.

### S3 File Upload (Coming Soon)

### Facebook Login (Coming Soon)

### Sending Email (Coming Soon)

### Background Processes (Coming Soon)
