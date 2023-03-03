#!/usr/bin/env zx

import { stripIndent } from "common-tags";

let name = await question("Component name? ");
await $`mkdir ${name}`;
fs.writeFile(`${name}/index.js`, `export {default} from "./${name}.jsx"`);
fs.writeFile(
  `${name}/${name}.jsx`,
  stripIndent`
import React from 'react';
import classnames from 'classnames';
import PropTypes from 'prop-types';

import styles from './${name}.module.scss';

export default function ${name}({}) {
  // TODO (sbadragan): implement this component 
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
// TODO (sbadragan): implement or remove this style
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
  // TODO (sbadragan): implement or remove this test
  it('renders correctly', () => {
    expect(renderComponent()).toMatchSnapshot();
  });
});
`
);
