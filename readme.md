# Client Project Brief

**Scenario Overview**

**Client:** James Smith, a freelance web designer

**Project:** Portfolio Website Deployment

**Project Description:**  James Smith, a freelance web designer, wants to showcase his work and attract potential clients through an online portfolio. He has designed a modern, responsive single-page website using the Next.js framework. James requires this website to be hosted on a robust, scalable, and cost-effective platform. Additionally, the website needs to be highly available and deliver fast loading times for a global audience.

**Your Role:** As a team of cloud engineers, your task is to deploy James's Next.js portfolio website on AWS using Infrastructure as Code (IaC) principles with Terraform. This project will give you hands-on experience with Terraform, S3, and CloudFront, mimicking a real-world deployment scenario.

**Problem Statement**

James needs his portfolio website to be:

**1. Highly Available:** The website should be accessible to users worldwide with minimal downtime.

**2. Scalable:** As his portfolio gains traction, the hosting solution should handle increased traffic without performance degradation.

**3.Cost-Effective:** Hosting costs should be optimized, avoiding unnecessary expenses.

**4. Fast Loading:** The website should load quickly for visitors, providing a seamless user experience.

Given these requirements, deploying the website using AWS services such as S3 for static hosting and CloudFront for content delivery is an ideal solution. Using Terraform will allow you to automate and manage the infrastructure efficiently.

**Project Outcome**

By the end of this project, you should have:

**1. Deployed a Next.js Website:** Successfully deployed the Next.js portfolio site on AWS.

**2. Implemented Infrastructure as Code:** Used Terraform to automate the creation of AWS resources.

**3. Configured Global Content Delivery:** Set up AWS CloudFront to deliver the website content globally with low latency.

**4. Ensured Security and Performance:** Applied best practices for security and performance, ensuring a fast and secure website for James's portfolio.

**5. Deploy everything to github:** Create a github repo and host all your project files and code there.

**Here is the Architecture:**

![]()

**Quick Overview of Next.js**

Before we dive into setting up and deploying a Next.js application, let's take a moment to understand what Next.js is, why it's used, and its common use cases. This overview will give you a solid foundation and help you appreciate the capabilities of Next.js.

**What is Next.js?**

Next.js is a popular open-source framework built on top of React, a JavaScript library for building user interfaces. Developed and maintained by Vercel, Next.js provides a robust set of features that enhance the development experience and streamline the process of building web applications.

**Why Use Next.js?**

Next.js is designed to make it easier to create fast, scalable, and SEO-friendly web applications. Here are some key benefits of using Next.js:

1. Server-Side Rendering (SSR): Next.js supports server-side rendering out of the box. This means that web pages are generated on the server for each request, improving initial load times and making the application more SEO-friendly.

2. Static Site Generation (SSG): Next.js allows you to pre-render pages at build time, creating static HTML files. This results in faster load times and improved performance, as static files can be served directly by a CDN.

3. API Routes: Next.js includes a built-in API routing system, allowing you to create serverless functions and API endpoints within the same project. This makes it easy to handle backend logic without needing a separate server.

4. File-Based Routing: Next.js uses a file-based routing system, where the file structure of the pages directory determines the application's routes. This simplifies navigation and routing within the application.

5. Built-In CSS and Sass Support: Next.js supports importing CSS and Sass files, allowing you to style your application easily. It also has built-in support for CSS-in-JS solutions like styled-components.

6. Automatic Code Splitting: Next.js automatically splits your code into smaller chunks, loading only the necessary JavaScript for the current page. This improves load times and overall performance.

**Common Use Cases**

Next.js is versatile and can be used for a variety of web applications. Some common use cases include:

1. Static Websites: Perfect for blogs, landing pages, and portfolio sites where content doesn't change frequently. Static Site Generation (SSG) makes these sites incredibly fast.

2. E-Commerce Sites: Next.js's server-side rendering (SSR) capabilities ensure that product pages load quickly and are optimized for search engines, improving user experience and SEO.

3. Corporate Websites: Companies use Next.js to build scalable, high-performance websites that need to handle large amounts of traffic and provide a seamless user experience.

4. Web Applications: From simple dashboards to complex web apps, Next.js's built-in API routes and server-side rendering capabilities make it a great choice for developing dynamic web applications.

5. Blogs and Content Sites: With Markdown and MDX support, Next.js is ideal for creating content-driven sites that are easy to maintain and SEO-friendly.

**Summary**

Next.js is a powerful framework that extends React's capabilities, making it easier to build fast, scalable, and SEO-friendly web applications. Whether you're creating a static site, a dynamic web app, or an e-commerce platform, Next.js provides the tools and features you need to deliver a great user experience.

Steps:

1. Create a new GitHub repo 

2. Clone the Portfolio Starter Kit:

`npx create-next-app@latest nextjs-blog --use-npm --example "https://github.com/vercel/next-learn/tree/main/basics/learn-starter"`

![](images/2_clone_portfolio_starter_kit.png)

![](images/3_portfolio_kit_cloned.png)

3. Navigate to the Project Directory:

`cd nextjs-blog`

`npm run dev`

![](images/4_new_node_v_needed.png)

If you, like me, encountered this message, then you will need to update `node` version. I used `homebrew` for this. 

Try tun the following first: `brew upgrade node`. If this will not work, try run the following commands to uninstall the existing Node.js version (if needed):

```
sudo rm -rf /usr/local/lib/node_modules
sudo rm -rf /usr/local/bin/node
sudo rm -rf /usr/local/bin/npm
```

Then run the following: `brew install node` and `node -v` to check that now you are using the correct `node` version.

This should start your next.js app on `http://localhost:3000/`

![](images/5_node_app_localhost.png)

4. After this in the root of the project folder, create a new file called `next.config.js` and paste the following code inside this file:

![](images/6_next_config_js.png)

5. Run the following command: `npm run build` to create a build of our application to be able to deploy our satic application to `s3`, which would generate an `out` folder, which will be used to deploy our app on Amazon `s3`.

![](images/7_run_build.png)

![](images/8_out_folder_generated.png)

6. Set up Terraform Directory, that should me inside the nextjs blog folder:

![](images/9_create_tf_dir.png)

![](images/10_tf_dir.png)

7. Set up `state.tf` file, where we will set up out terraform state with s3 and DynamoDB:

![](images/11_state_tf.png)

![](images/11_1_state_tf_created.png)

8. Create `main.tf` file, where we will put all the s3 configuration inside:

![](images/12_main_tf.png)

We will set up s3 configuration and also s3 ownership controls to ensure, that we, as s3 bucket owners, have complete control of the objects in the bucket. This will be true even the objects will be uploaded by different aws account.

![](images/13_s3_ownership_control.png)

We will also set up public access to the s3 bucket. When the s3 bucket is set up, by default it blocks all the public access to it. Setting up these parameters to `false` allows bucket and objects inside it to be publicly accessible.

![](images/14_block_public_access.png)

No we need to set bucket ACL to public read so the objects in the bucket will be publicly accessible. 
`depends_on` ensures that ownership control and public access block settings are applied before. setting the ACL.

![](images/15_bucket_acl.png)

Now we need to attach a bucket policy to allow a public read acces to the objects in s3. Bucket policy defines detailed access permissions for the bucket and its objects using IAM policies.

![](images/16_bucket_policy.png)

These all are refined layers of control for s3 bucket: for fine-grained control, security best practices, compliance, flexibility.

9. Now we need to set up CloudFront service to serve static website from Amazon s3. CloudFront will use 3s bucket as its origin and provide CDN (Content Delivery Neywork) for faster access and better performance. 

First define origin access identity (OAI), which is special CloudFront user, that gives CloudFront access to the s3 bucket, so the applicaiton in the bucket can be served by CloudFront. By setting OAI, we will ensure that only CloudFront can directly access s3 bucket, which is also can be considered as extra layer of security.

`origin` block specifies origins settings for our CloudFront distribution. Domain name of the origin is the s3 bucket, that tells CloudFront, where to fetch the content from. `origin_id` helps to uniquely identify this origin within the CloudFront distribution. `s3_origin_config` block sets up the settings, specific to the s3 as the origin. CloudFront will use that OAI to access that s3 bucket. This configuration ensures that noone, except CloudFront, will be able to access s3 bucket. 

Benefits of using CloudFront. It has global content distribution. It caches content at edge locations around the world, which ensures fast delivery to users regardless of their geographic location. It gives the improved perfomance by serving the content from the nearest edge location. CloudFront reduces the latency and speeds up the load time of the static website. CloudFront also provides enhanced security, as OAI restricts direct access to the s3 bucket, ensuring that content can be access only through CloudFront. Also it provides scalabiliy, because CloudFront automatically scales to handle the traffic load, providing reliable and scalable solution to serve the applicaion. 

We need to set up additional configuration for CloudFront to make sure that content delivery through CloudFront is optimized. 

`enabled = true` means that CloudFront distribution is active and will serve the content as soon as it is deployed. `false` setting will mean that distribution will be created, but won't be enabled. `is_ipv6_enabled = true` will set up `ipv6` support for the CloudFront. `default_root_object`: when the request is made to the root url of our distribution, CloudFront will serve `index.html` from the origin, which is s3 bucket. 

We also need to enable a few caching behaviors, that will define how CloudFront should handle the requests to our origin.

`allowed_methods` specify http methods allowed for the caching behaviour. `cached_methods` specify http methods to actually cache. By caching `get` and `head` requests, we are making sure that these common retrieval requests are served quickly from the cache. `target_origin_id` links cached behavior to the specified origin. This ensures that the requests, matching this behavior, are directed to the s3 bucket.  

`query_string` indicates, whether to forward the query string to the origin: `false` means that they are not forwarded, which simplifies caching and improves performance. `cookies` specifies, how cookies forwarded to the s3 bucket: `none` means that cookies are not forwarded and this can ensure caching efficiency and reduce complexity. 

`viewer_protocol_policy` ensures that viewers are redirected to the https. This policy improves security by ensuring that all communications between the client and the CloudFront CDN are secured and encrypted. `min_ttl` is the minimum amount of time the object is cached: `0` sets to the immediate update if needed; `default_ttl` is the default amount of time the object is cached; `max_ttl` is the maximun amount of time the object is cached: in our case we are making cure that the content is refreshed at least ones a day (86400 s = 24 hrs).

`restrictions` resource is needed to configure the geographic restrictions for the CloudFront distribution. This determines, from which location the users can access our content; `none` in our case will indicate that we want everyone to have access to our website (could be `whitelist` means access only from specified countries, `blacklist` means denial of access from specified countries).

`viewer_certificate` configure ssl and tsl settings for our CloudFront distribution, which ensures secure communication between our users and CloudFront. `cloudfront_default_certificate` set to `true` tells the CloudFront to use its default ssl and tsl certificate. Default certificate supports ssl and tsl termination, as well as https connections, using a shared certificate for our `cloudfront.net` domain. We will get a standard CloudFront URL, and it will be secured by default, beacuse we are using default CloudFront certificate. Using the certificate ensures that the data transmitted between the end user and CloudFront is encrypted and secure.

Let's create our s3 bucket by running: `aws s3api create-bucket --bucket aace-my-tf-website-state --region us-east-1`:

![](images/17_create_s3_bucket.png)

![](images/18_s3_bucket_created.png)

Let's create a DynamoDB table by running: `aws dynamodb create-table --table-name my-db-website-table --attribute-definitions Attr
ibuteName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=
2,WriteCapacityUnits=2`

![](images/19_create_dynamodb_tbl.png)

Now we need to update `state.tf` file for two new properties that we have just created.

![](images/20_update_state_tf.png)

