% README


English
-------

This is my `~/texmf` directory, that is,
my TeX and METAFONT tree.
It contains my own formats: `spplain` and `esplain`,
which are like Knuth's `plain`,
but adapted to Spanish.

To install it, please follow this plan:

- Install Debian with default options.
- Install the packages:
  `texlive-base` (including its recommended `lmodern`),
  `texlive-metapost` (but not its recommended `feynmf`),
  `texlive-fonts-recommended` (but not `tipa`),
  `git`, and
  `gcc` (including `libc6-dev`).
- Install `spplain` and `esplain`.

The first two steps are not necesary,
but they provide a scenario
where it is sure that everything works all right.
In other words, you need a working computer with
a good Linux, TeXLive, Git, and a C compiler.

In order to perform the last step,
you have to write,
as normal user but with sudoer permissions,
the following commands in a terminal:

```
cd
git clone https://github.com/ramoncasares/texmf.git
texmf/exe/sh/install.sh
```

Command `cd` without arguments makes
your home directory the working directory.
Command `git clone` creates a directory `~/texmf`,
and populates it.
Command `install.sh` compiles the C binaries,
builds the binary TeX formats,
creates a directory `~/bin` if there is not any,
and populates it with symbolic links to executables
(scripts and binaries).
It is convenient to add `~/bin` to the path, thus:
`PATH="$HOME/bin:$PATH"`.

Now, to create the pdf version of a tex document
named `filename.tex` in your working directory,
you just have to enter `wpdf filename` in a terminal.

The TeX sources of the documentation are in
dir `~/texmf/doc`.
You can use `wpdf` to build the pdf versions.
This way you can build all the documentation.

Happy TeXing!


Español
-------

Este es mi directorio `~/texmf`,
que es en donde está mi árbol TeX y METAFONT.
Contiene mis formatos: `spplain` y `esplain`,
que son como el formato `plain` de Knuth,
pero adaptados al castellano.

Para instalarlo, sigue, por favor, estos pasos:

- Instala Debian con las opciones por defecto.
- Instala los paquetes:
  `texlive-base` (incluyendo su recomendado `lmodern`),
  `texlive-metapost` (pero no su recomendado `feynmf`),
  `texlive-fonts-recommended` (pero no `tipa`),
  `git`, y
  `gcc` (incluyendo `libc6-dev`).
- Instala `spplain` y `esplain`.

Los primeros dos pasos no son necesarios,
pero proporcionan un escenario en el que es seguro
que todo funciona correctamente.
En otras palabras, necesitas un ordenador equipado con
un buen Linux, TeXLive, Git, y un compilador C.

Para el último paso, tienes que escribir,
como usuario normal pero con permisos de _sudoer_,
los siguientes comandos en un terminal:

```
cd
git clone git://github.com/ramoncasares/texmf.git
texmf/exe/sh/installtex.sh
```

El comando `cd` sin argumentos
hace que el directorio del usuario
sea el directorio de trabajo.
El comando `git clone` crea un directorio `~/texmf`,
y lo llena.
El comando `install.sh` compila los binarios C,
construye los formatos TeX binarios,
crea un directorio `~/bin` si es que no hay ya uno,
y lo llena con enlaces simbólicos a los ejecutables
(_scripts_ y binarios).
Es conveniente añadir `~/bin` al _path_, así:
`PATH="$HOME/bin:$PATH"`.

Ahora, para crear la versión pdf de un documento TeX
llamado `filename.tex` que se encuentre en el directorio de trabajo,
bastará escribir `wpdf filename` en el terminal.

La documentación, en formato fuente TeX, se encuentra en
el directorio `~/texmf/doc`.
Si quieres obtener la versión pdf utiliza `wpdf`.
De este modo puedes reconstruir toda la documentación.

¡Feliz TeXeado!
