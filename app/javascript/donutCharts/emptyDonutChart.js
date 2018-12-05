class EmptyDonutChart {
  constructor({ yes = 0, no = 0, maybe = 0, '': awaiting = 0 }) {
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

export default EmptyDonutChart
