module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  testMatch: ['**/*.test.ts'],
  testPathIgnorePatterns: [
    '/node_modules/',
    'test/value-object/primitives/StringValueObject/isEmpty.test.ts',
  ],
};
