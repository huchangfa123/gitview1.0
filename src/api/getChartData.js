import Vue from 'vue'
import config from '../config'

export default {
  getLanguageData () {
    return Vue.http.get(`${config.baseurl}/search/languages`).then(res => res)
  }
}
