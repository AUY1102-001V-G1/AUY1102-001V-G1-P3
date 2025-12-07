const baseConfig = require('./jest.config.js');

module.exports = {
  ...baseConfig,
  testPathIgnorePatterns: [
    '/node_modules/',
    'test/value-object/primitives/StringValueObject/isEmpty.test.ts',
  ],
};
