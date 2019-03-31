import React from 'react';
import Factory from 'donutCharts/factory';

class DonutChart extends React.Component {
  constructor(props) {
    super(props);
    this.myRef = React.createRef();
    this.generator = Factory.createChartGenerator(props);
  }

  componentDidMount() {
    this.generator.bindto = this.myRef.current;
    this.generator.generate();
  }

  render() {
    return <div ref={this.myRef} />;
  }
}

export default DonutChart;
