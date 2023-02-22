#!/usr/bin/env zx

import { stripIndent } from "common-tags";

let name = await question("Component name? ");
await $`mkdir ${name}`;
fs.writeFile(`${name}/index.js`, `export {default} from "./${name}.jsx"`);
fs.writeFile(
  `${name}/${name}.jsx`,
  stripIndent`
import React from 'react';
import classNames from 'classnames';
import PropTypes from 'prop-types';

import style from './${name}.module.scss';

export function ${name}({}) {

}

${name}.displayName = '${name}';

${name}.propTypes = {
};

${name}.defaultProps = {
};
`
);
fs.writeFile(
  `${name}/${name}.module.scss`,
  `
@import 'colors';
@import 'fonts';
`
);
fs.writeFile(
  `${name}/${name}.spec.js`,
  `
import React from 'react';
import { renderWithProviders } from 'test/test-utils';
import ${name} from './${name}';

const renderComponent = props => renderWithProviders(<${name} {...props} />);

describe('${name}', () => {
  it('renders correctly', () => {
    expect(renderComponent()).toMatchSnapshot();
  });
});
`
);
