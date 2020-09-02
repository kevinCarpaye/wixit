import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'searchrticle'
})
export class SearchrticlePipe implements PipeTransform {

  transform(value: any, filterString: string, propName: string): any {
    console.log(value);
    console.log(propName);
    console.log(filterString)
    if (filterString != null) {
      if (value.length <= 1) {
        return value;
      }
      const resultArray = [];
      for (const item of value) {
        let name = item[propName].toLowerCase()
        if (name.includes(filterString)) {
          resultArray.push(item)
        }
      }
      return resultArray;
    }
    else {
      return value;
    }
  }

}
