[Veewee](https://github.com/jedi4ever/veewee) definition file for a 64-bit Quantal Quetzal base box.

### Checkout veewee source:

    $ git clone git://github.com/jedi4ever/veewee.git
    $ cd $VEEWEE_DIR
    $ bundle

### Create a definitions folder:

    $ mkdir -p definitions

### Clone this repository:

    $ git clone git://github.com/ngpestelos/quantal64.git

### Build a new base box (VirtualBox):

    $ bundle exec veewee vbox build 'quantal64'

### Package an existing box (VirtualBox): 

    $ bundle exec veewee vbox package 'quantal64'
