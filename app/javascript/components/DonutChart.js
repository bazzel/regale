import React from "react"
import PropTypes from "prop-types"

class DonutChart extends React.Component {
  constructor(props) {
    super(props);
    this.myRef = React.createRef();
  }

  componentDidMount() {
    const generator = Factory.createChartGenerator(this.props);
    generator.bindto = this.myRef.current;
    generator.generate();
  }

  render () {
    return (
      <div ref={this.myRef} />
    );
  }
}

DonutChart.propTypes = {
  greeting: PropTypes.string
};

class Factory {
  static createChartGenerator(props) {
    const {
      yes = 0,
      no = 0,
      maybe = 0,
      awaiting = 0
    } = props;
    const total = yes + no + maybe + awaiting;

    if (total == 0)
      return new EmptyChart(props);

    return new FilledChart(props);
  }
}

class EmptyChart {
  constructor({ yes = 0, no = 0, maybe = 0, awaiting = 0 }) {
    this.yes = yes;
    this.no = no;
    this.maybe = maybe;
    this.awaiting = awaiting;
    this.c3ChartDefaults = $().c3ChartDefaults();
  }

  bindto(bindto) {
    this.bindto = bindto;
  }

  generate() {
    c3.generate({...this.defaultChartConfig, ...this.chartConfig});
    this._addTitle();
  }

  _addTitle() {  }

  get defaultChartConfig() {
    return this.c3ChartDefaults.getDefaultDonutConfig('-');
  }

  get chartConfig() {
    return {
      size: {
        width: 60,
        height: 71
      },
      bindto: this.bindto,
      tooltip: this.tooltip,
      data: this.data
    }
  }

  get tooltip() {
    return {
      show: false
    }
  }

  get data() {
    return {
      type : 'donut',
      columns: this.columns
    };
  }

  get columns() {
    return [
      ['x', 0],
      ['y', 1]
    ]
  }

  get total() {
    return this.yes + this.no + this.maybe + this.awaiting;
  }
}

class FilledChart extends EmptyChart {
  get defaultChartConfig() {
    return this.c3ChartDefaults.getDefaultRelationshipDonutConfig();
  }

  get tooltip() {
    return {
      contents: $().pfDonutTooltipContents
    }
  }

  _addTitle() {
    const donutChartTitle = d3.select(this.bindto).select('text.c3-chart-arcs-title');
    donutChartTitle.insert('tspan').text(this.total).classed('list-view-donut-title', true);
  }

  get columns() {
    return [
      ['Awaiting', this.awaiting],
      ['No', this.no],
      ['Maybe', this.maybe],
      ['Yes', this.yes],
    ]
  }
}

export default DonutChart
