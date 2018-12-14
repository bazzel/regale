import EmptyDonutChart from 'donutCharts/emptyDonutChart'
import FilledDonutChart from 'donutCharts/filledDonutChart'

class Factory {
  static createChartGenerator(props) {
    const { acceptStatusesSummary } = props;
    const {
      yes,
      no,
      maybe,
      '': awaiting
    } = acceptStatusesSummary;
    const total = yes + no + maybe + awaiting;

    if (total == 0)
      return new EmptyDonutChart(acceptStatusesSummary);

    return new FilledDonutChart(acceptStatusesSummary);
  }
}

export default Factory
