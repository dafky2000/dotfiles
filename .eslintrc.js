module.exports = {
  "extends": [
    "eslint:recommended"
  ],
  "parser": "babel-eslint",
  "parserOptions": {
    "sourceType": "module",
  },
  "rules": {
    "indent": [
      "error",
      2,
      { "SwitchCase": 1 },
    ],
    "linebreak-style": [
      "error",
      "unix",
    ],
    "quotes": [
      "error",
      "single",
    ],
    "semi": [
      "error",
      "always",
    ],
    "no-console": "off",
    "no-debugger": "warn"
  },
  "env": {
    "browser": true,
    "es6": true,
    "jquery": true,
  },
  "plugins": [
    "html"
  ],
  "globals": {
    "customElements": true,
    "HTMLImports": true,
    "Polymer": true,
    "ShadyDOM": true,
    "ShadyCSS": true,
    "JSCompiler_renameProperty": true
  },
};
