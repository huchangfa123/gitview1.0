import getData from '../api/getChartData'

export const getLanguageData = () => {
  return getData.getLanguageData().then(data => Promise.resolve(data))
}

