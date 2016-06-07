# Thoughtbox

Thoughtbox is an application to store links for future reference. This application is deployed [here](http://limitless-bastion-85181.herokuapp.com). An authorized user can do the following:

- Log in to see their links
- Logout of their account
- Create new links with a title and valid URL
- View all links
- Toggle the status of a link between read and unread
- Edit the title and URL of an existing link
- Filter the list by read/unread links
- Sort the list of links alphabetically
- "Fuzzy" search links by title

This application is built in Rails with client-side JavaScript/jQuery/AJAX. The following functionality does not require a page reload:
- Toggle the status of a link between read and unread
- Filter the list by read/unread links
- Sort the list of links alphabetically
- "Fuzzy" search links by title

If you would like to try this application in production, the following credentials will get you into a "public" thoughtbox: (email: guest@example.com, password: password)

## Thoughtbox at work
Here is some of the functionality of Thoughtbox for reference:
![example gif](http://g.recordit.co/sHszaV4H7N.gif)

## Installation and testing
Thoughtbox is built on Rails, so standard installation procedure applies:
```
$ git clone https://github.com/erinnachen/thoughtbox-eval
$ cd thoughtbox-eval
$ bundle
$ rake db:{create,migrate}
```
To run the app locally:
```
$ bundle exec rails server
```
and navigate to [localhost:3000](localhost:3000)

The test suite is written in RSpec and can be run with:
```
$ rspec
............................

Finished in 12.87 seconds (files took 3.62 seconds to load)
28 examples, 0 failures
```
