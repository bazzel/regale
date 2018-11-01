const paths = [
  'patternfly/dist/sass',
  'bootstrap-sass/assets/stylesheets',
  'font-awesome-sass/assets/stylesheets'
];

const resolvedModules = paths.map((path) => `node_modules/${path}`);

module.exports = {
  resolve: {
    modules: resolvedModules
  }
};

