# Gamamia

<a href="https://assembly.com/gamamia/bounties?utm_campaign=assemblage&utm_source=gamamia&utm_medium=repo_badge"><img src="http://badger.asm.co/gamamia/badges/tasks.svg" height="24px" alt="Open Tasks" /></a>
[![Build Status](https://travis-ci.org/asm-products/gamamia.svg)](https://travis-ci.org/asm-products/gamamia)
[![Code Climate](https://codeclimate.com/github/asm-products/gamamia/badges/gpa.svg)](https://codeclimate.com/github/asm-products/gamamia)
[![Test Coverage](https://codeclimate.com/github/asm-products/gamamia/badges/coverage.svg)](https://codeclimate.com/github/asm-products/gamamia)
[![Dependency Status](https://gemnasium.com/asm-products/gamamia.svg)](https://gemnasium.com/asm-products/gamamia)

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/asm-products/gamamia)

## An independent game discovery platform

This is a product being built by the Assembly community. You can help push this idea forward by visiting [https://assembly.com/gamamia](https://assembly.com/gamamia).

### How To Get Gamamia Set Up

Right now, we are developing everything on the develop branch of Gamamia at [https://github.com/asm-products/gamamia/tree/develop](https://github.com/asm-products/gamamia/tree/develop). The main branch of this repository is set up to faciliate the daily newsletter updates, until we have verison 2.0 of Gamamia all set up.

Gamamia is run on Rails. In order to get everything set up, you will want to have Postgres installed as well.

To start working with Gamamia locally:

##### Clone Gamamia
`git clone https://github.com/asm-products/gamamia.git`

##### Switch to Develop Branch
`git checkout develop`

##### Run Rake to set up Database and Start Rails server
`rake db:create db:migrate db:seed`

`rails s`

And that's it! You'll have a version of this app running at http://localhost:3000/ that you can start playing around with. Please let us know if you run into any problems.