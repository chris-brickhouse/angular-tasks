import { environment } from './../environments/environment';

// export const environment = {
//   production: false,
//   api: 'https://bdaoutreach.org',
// };

export function getAPI(urlConst: string): string {
  return environment.api + '/api/' + urlConst;
}

export function getImageBaseUrl(): string {
  return environment.api;
}
