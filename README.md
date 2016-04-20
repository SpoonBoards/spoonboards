# SpoonBoards

## Introduction
<a href="http://www.spoonflower.com">Spoonflower</a> is a print-on-demand company that provides custom-printed fabric, wallpaper and gift wrap. Users can search through hundreds of thousands of incredible designs, but that much variety can be a little overwhelming --  especially when you don’t have a tool that can help you easily categorize your top picks.

**SpoonBoards** is a Ruby on Rails app that lets users to browse the Spoonflower marketplace and create unique, curated collections by adding designs to boards. Feel free to explore **SpoonBoards** on <a href="https://spoonboards.herokuapp.com"> Heroku. </a>

## Features & Functionality

Let’s say you’re working on decorating your kid’s room using a dinosaur theme. Our app makes it easy to search for designs using Spoonflower’s API. Infinite scroll pulls up dozens of designs, and the user can quickly create a board and add designs to it. If you hover over the design, you'll get more detailed information.

<a href="https://s3-us-west-2.amazonaws.com/codepen-assets-cs-training/Screenshot+1.jpg"></a>

After creating the dinosaur board, you might want to share it with friends or family. We use OmniAuth to communicate with <a href="https://github.com/jot/omniauth-pinterest">Pinterest’s API.</a> You can create pins, new Pinterest boards and even use its service to log into **SpoonBoards**.  

`screenshot goes here`

The board has several features in the hamburger drawer menu, including the ability to duplicate a board, update the name and adjusting privacy settings. Users can toggle the public/private checkbox so boards can be hidden from others or shared with people who don't have a **SpoonBoards** account. It's all about the user's preference.

`screenshot goes here`

Now you’re ready to move on with your dino decorating, but you need to see your board in person first. **SpoonBoards** allows you to add a board sampler to your cart on one of <a href="http://www.spoonflower.com/spoonflower_fabrics">Spoonflower’s base fabrics</a>, so you can have it printed on the material that best suits your needs. From the board page, you can also add individual swatches to your cart.

`screenshot goes here`

<a href="https://stripe.com/docs/api">Stripe’s API</a> keeps the checkout process easy. Once the transaction is complete, SpoonBoards communicates with Spoonflower’s API to generate an order, and soon you would receive your dinosaur collection printed onto fabric.

## Future Targets

Not only is SpoonBoards an efficient organizational tool, we’re adding another avenue through which Spoonflower community members can interact with each other. As this app grows, developing the social media aspect would be a big priority.

We also hope that by making board samplers easy to purchase, we give users the ability plan out their project needs and generate more conversions.

## Additional Information

Here are links to the <a href="https://www.lucidchart.com/invitations/accept/87de5d0d-6698-4cdf-bffd-e103a8a1df51"> ERD diagram</a> and <a href="https://www.lucidchart.com/documents/view/fdcc9410-3acf-4e74-9b95-4aac6a0c6e38"> wireframe. </a>
