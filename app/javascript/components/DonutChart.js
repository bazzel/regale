import React from "react"
import PropTypes from "prop-types"

class DonutChart extends React.Component {
  constructor(props) {
    super(props);
    this.myRef = React.createRef();
  }

  componentDidMount() {
    const {
      yes = 0,
      no = 0,
      maybe = 0,
      awaiting = 0
    } = this.props;
    const total = yes + no + maybe + awaiting;
    const c3ChartDefaults = $().c3ChartDefaults();

    let donutData = {
      type : 'donut',
      columns: [
        ['Awaiting', awaiting],
        ['No', no],
        ['Maybe', maybe],
        ['Yes', yes],
      ],
    };
    let defaultChartConfig = c3ChartDefaults.getDefaultRelationshipDonutConfig();
    if (total == 0) {
      donutData = {
        type : 'donut',
        columns: [
          ['x', 0],
          ['y', 1]
        ],
      };
      defaultChartConfig = c3ChartDefaults.getDefaultDonutConfig();
    }

    const chartConfig = {
      size: {
        width: 60,
        height: 71
      },
      bindto: this.myRef.current,
      tooltip: {
        contents: $().pfDonutTooltipContents
      },
      data: donutData
    }

    c3.generate({...defaultChartConfig, ...chartConfig});
    const donutChartTitle = d3.select(this.myRef.current).select('text.c3-chart-arcs-title');
    donutChartTitle.insert('tspan').text(total).classed('list-view-donut-title', true);
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
export default DonutChart
