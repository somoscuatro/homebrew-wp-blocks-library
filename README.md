# WordPress Blocks Library

This tool downloads ACF Gutenberg Blocks and Components from the [somoscuatro
blocks library](https://github.com/somoscuatro/wp-blocks-library).

Our library contains a collection of blocks that can be reused in your theme,
such as hero, CTA, accordions, etc. Components are reusable templates that can
be used by multiple blocks or templates (e.g., image, button, etc.).

## Prerequisites

Our blocks are designed to work with themes that follow the structure of [our
starter theme](https://github.com/somoscuatro/sc-starter-theme).

You can scaffold a new WordPress project that uses our starter theme by using
[our `wp-project-scaffold` Homebrew
command](https://github.com/somoscuatro/homebrew-wp-project-scaffold).

## Installation

To install the WordPress Blocks Library, follow these steps:

1. Add the custom Homebrew tap:

    ```shell
    brew tap somoscuatro/homebrew-wp-blocks-library
    ```

2. Install the `wp-blocks-library` tool via Homebrew:

    ```shell
    brew install wp-blocks-library
    ```

## Usage

Navigate to your theme folder and run the following command to install a block:

```shell
wp-blocks-library add block [block-name]
```

This will automatically install the block in your theme's `src/blocks` folder
and install all dependencies needed by the block.

You can also install components by running:

```shell
wp-blocks-library add component [component-name]
```

To remove a block, use:

```shell
wp-blocks-library remove block [block-name]
```

And to remove a component, use:

```shell
wp-blocks-library remove component [component-name]
```

Please note that when you remove a block, dependencies are not removed
automatically to avoid deleting dependencies needed by other blocks. You can
manually remove the component with the command mentioned above.

## How to Contribute

Any kind of contribution is very welcome!

Please be sure to read our [Code of
Conduct](https://raw.githubusercontent.com/somoscuatro/homebrew-wp-blocks-library/main/CODE_OF_CONDUCT.md).

If you notice something wrong please open an issue or create a Pull Request or
just send an email to [tech@somoscuatro.es](mailto:tech@somoscuatro.es). If you
want to warn us about an important security vulnerability, please read our
Security Policy.

## License

All code is released under MIT license version. For more information, please
refer to
[LICENSE.md](https://raw.githubusercontent.com/somoscuatro/homebrew-wp-blocks-library/main/LICENSE.md)
