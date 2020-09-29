import {
  Container,
  Typography,
} from '@material-ui/core';
import { withStyles } from '@material-ui/core/styles';

const styles = {
  'Container-2635': {
    flexDirection: 'column',
    alignItems: 'flex-start',
    justifyContent: 'flex-start',
    fillSpace: 'no',
    padding: '["40", "40", "40", "40"]',
    margin: '["0", "0", "0", "0"]',
    background: '{"r" => 255, "g" => 255, "b" => 255, "a" => 1}',
    color: '{"r" => 0, "g" => 0, "b" => 0, "a" => 1}',
    width: '800px',
    height: 'auto',
  },
  'Container-9083': {
    flexDirection: 'row',
    alignItems: 'flex-start',
    justifyContent: 'flex-start',
    fillSpace: 'no',
    padding: '["40", "40", "40", "40"]',
    margin: '["0", "0", "40", "0"]',
    background: '{"r" => 255, "g" => 255, "b" => 255, "a" => 1}',
    color: '{"r" => 0, "g" => 0, "b" => 0, "a" => 1}',
    width: '100%',
    height: 'auto',
  },
  'Container-9175': {
    flexDirection: 'column',
    alignItems: 'flex-start',
    justifyContent: 'flex-start',
    fillSpace: 'no',
    padding: '["0", "20", "0", "20"]',
    margin: '["0", "0", "0", "0"]',
    background: '{"r" => 255, "g" => 255, "b" => 255, "a" => 1}',
    color: '{"r" => 0, "g" => 0, "b" => 0, "a" => 1}',
    width: '40%',
    height: '100%',
  },
  'Typography-4439': {
    fontSize: '23',
    textAlign: 'left',
    fontWeight: '400',
    color: '{"r" => 92, "g" => 90, "b" => 90, "a" => 1}',
    margin: '[0, 0, 0, 0]',
    text: 'Craft.js is a React framework for building powerful & feature-rich drag-n-drop page editors.',
  },
  'Container-991': {
    flexDirection: 'column',
    alignItems: 'flex-start',
    justifyContent: 'flex-start',
    fillSpace: 'no',
    padding: '["0", "20", "0", "20"]',
    margin: '["0", "0", "0", "0"]',
    background: '{"r" => 255, "g" => 255, "b" => 255, "a" => 1}',
    color: '{"r" => 0, "g" => 0, "b" => 0, "a" => 1}',
    width: '60%',
    height: '100%',
  },

}

function Home(props) {
  const { classes } = props;

  return (
    <>
      <Container className={classes[`Container-2635`]}>
<Container className={classes[`Container-9083`]}>
<Container className={classes[`Container-9175`]}>
<Typography className={classes[`Typography-4439`]}>
Craft.js is a React framework for building powerful & feature-rich drag-n-drop page editors.
</ Typography>
</ Container>
<Container className={classes[`Container-991`]}>
<Typography className={classes[`Typography-6506`]}>
Everything you see here, including the editor, itself is made of React components. Craft.js comes only with the building blocks for a page editor; it provides a drag-n-drop system and handles the way user components should be rendered, updated and moved, among other things. <br /> <br /> You control the way your editor looks and behave.
</ Typography>
</ Container>
</ Container>
</ Container>

    </>
  );
}

export default withStyles(styles)(Home);