import EmptyDonutChart from 'donutCharts/emptyDonutChart'

class FilledDonutChart extends EmptyDonutChart {
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

export default FilledDonutChart
