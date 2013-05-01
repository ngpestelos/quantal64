[Veewee](https://github.com/jedi4ever/veewee) definition file for a 64-bit Quantal Quetzal base box.

### Checkout veewee source

    $ git clone git://github.com/jedi4ever/veewee.git
    $ cd $VEEWEE_DIR
    $ bundle

### Create a definitions folder

    $ mkdir -p definitions

### Clone this repository

    $ cd definitions
    $ git clone git://github.com/ngpestelos/quantal64.git

### Build a new base box (VirtualBox)

    $ cd $VEEWEE_DIR
    $ bundle exec veewee vbox build quantal64

### Package a base box (VirtualBox)

    $ cd $VEEWEE_DIR
    $ bundle exec veewee vbox export quantal64

### Releases

    * quantal64-0.1.0.box (01 May 2013)
