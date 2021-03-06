COBRA!
======

Cobra is a [Continuous
Integration](http://en.wikipedia.org/wiki/Continuous_integration)
server that'll run your tests on demand and report their pass/fail status.

Because knowing may get you killed


Quickstart
----------

RubyGems:

    $ gem install cobra
    $ git clone git://github.com/you/yourrepo.git
    $ cobra yourrepo

Boom. Navigate to <http://localhost:4567> to see Cobra in action.
Check `cobra -h` for other options.

Basically you need to run `cobra` and hand it the path to a git
repo. Make sure this isn't a shared repo: Cobra needs to own it.

Cobra looks for various git config settings in the repo you hand it. For
instance, you can tell Cobra what command to run by setting
`cobra.runner`:

    $ git config --add cobra.runner "rake -s test:units"

Cobra doesn't care about Ruby, Python, or whatever. As long as the
runner returns a non-zero exit status on fail and a zero on success,
everyone is happy.

Need to do some massaging of your repo before the tests run, like
maybe swapping in a new database.yml? No problem - Cobra will try to
run `.git/hooks/after-reset` if it exists before each build phase.
Do it in there. Just make sure it's executable.

Want to notify IRC or email on test pass or failure? Cobra will run
`.git/hooks/build-failed` or `.git/hooks/build-worked` if they exist
and are executable on build pass / fail. They're just shell scripts -
put whatever you want in there.

Tip: your repo's `HEAD` will point to the commit used to run the
build. Pull any metadata you want out of that scro.


Other Branches
----------------------

Want Cobra to run against a branch other than `master`? No problem:

    $ git config --add cobra.branch deploy


Concurrent Push's - a kind of "queueing"
----------------------------------------

Cobra runs just one build at the time. If you expect concurrent push's
to your repo and want Cobra to build each in a kind of queue, just set:

    $ git config --add cobra.buildallfile tmp/cobra.txt

Cobra will save requests while another build runs. If more than one push
hits Cobra, he just picks the last after finishing the prior.


Campfire
-------------

Campfire notification is included, because it's what we use. Want Cobra
notify your Campfire? Put this in your repo's `.git/config`:

    [campfire]
    	user = your@campfire.email
    	pass = passw0rd
    	subdomain = whatever
    	room = Awesomeness
    	ssl = false

Or do it the old fashion way:

    $ cd yourrepo
    $ git config --add campfire.user chris@ozmm.org
    $ git config --add campfire.subdomain github
    etc.


Checkin' Status
----------------------

Want to see how your build's doing without any of this fancy UI crap?
Ping Cobra for the lowdown:

    curl http://localhost:4567/ping

Cobra will return `200 OK` if all is quiet on the Western Front. If
Cobra's busy building or your last build failed, you'll get `412
PRECONDITION FAILED`.


Multiple Projects
------------------------

Want CI for multiple projects? Just start multiple instances of Cobra!
He can run on any port - try `cobra -h` for more options.

If you're using Passenger, see [this blog post](http://chrismdp.github.com/2010/03/multiple-ci-joes-with-rack-and-passenger/).


HTTP Auth
----------------

Worried about people triggering your builds? Setup HTTP auth:

    $ git config --add cobra.user chris
    $ git config --add cobra.pass secret


GitHub Integration
--------------------------

Any POST to Cobra will trigger a build. If you are hiding Cobra behind
HTTP auth, that's okay - GitHub knows how to authenticate properly.

![Post-Receive URL](http://img.skitch.com/20090806-d2bxrk733gqu8m11tf4kyir5d8.png)

You can find the Post-Receive option under the 'Service Hooks' subtab
of your project's "Admin" tab.


Daemonize
----------------

Want to run Cobra as a daemon? Use `nohup`:

    $ nohup cobra -p 4444 repo &


Other CI Servers
------------------------

Need more features? More notifiers? Check out one of these bad boys:

* [Cerberus](http://cerberus.rubyforge.org/)
* [Integrity](http://integrityapp.com/)
* [CruiseControl.rb](http://cruisecontrolrb.thoughtworks.com/)
* [BuildBot](http://buildbot.net/trac)
* [Signal](http://www.github.com/dcrec1/signal)


Screenshots
------------------

![Building](http://img.skitch.com/20090806-ryw34ksi5ixnrdwxcptqy28iy7.png)

![Built](http://img.skitch.com/20090806-f7j3r65yecaq13hdcxqwtc5krd.)


Questions? Concerns?
---------------------------------

[Issues](http://github.com/OpenGotham/cobra/issues).


( Matthew jording :: mjording@iequalsi.com )
