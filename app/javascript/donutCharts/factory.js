import EmptyDonutChart from 'donutCharts/emptyDonutChart'
import FilledDonutChart from 'donutCharts/filledDonutChart'

class Factory {
  static createChartGenerator(props) {
    const {
      acceptStatus = {}
    } = props;
    const {
      yes = 0,
      no = 0,
      maybe = 0,
      '': awaiting = 0
    } = acceptStatus;
    const total = yes + no + maybe + awaiting;

    if (total == 0)
      return new EmptyDonutChart(acceptStatus);

    return new FilledDonutChart(acceptStatus);
  }
}

export default Factory
