import {Component} from '@angular/core';
import {HttpClient} from '@angular/common/http';

import {environment} from '../environments/environment';
import {map} from 'rxjs/operators';

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.scss']
})
export class AppComponent {

    public title = 'Welcome to Url Shorter';
    public url: string = null;
    public generatedUrl: string = null;
    public loading: boolean;
    public showStats: boolean;
    public analyticsData: Array<IAnalyticData> = [];

    constructor(private httpClient: HttpClient) {
    }


    public generateUrl(actualPath: string): void {
        this.generatedUrl = null;
        this.loading = true;
        this.httpClient.post(environment.apiUrl + 'getUrl', {url: actualPath}) .subscribe( this.displayShortUrl, this.handleError );
    }


    public showAnalytics(): void {
        this.showStats = false;
        this.loading = true;
        this.httpClient.get(environment.apiUrl + 'stats') .subscribe( this.displayAnalytics, this.handleError );
    }


    private displayShortUrl = (httpResponse: IHttpResponse): void => {
        this.generatedUrl = environment.apiUrl + httpResponse.result[0].url;
        this.url = null;
        this.loading = false;
    }


    private displayAnalytics = (httpResponse: IHttpResponse): void => {
        this.showStats = true;
        this.loading = false;
        this.analyticsData = httpResponse.result.map( value => ({...value, url: environment.apiUrl + value.url}) );
   }


    private handleError = (err) =>  window.alert(err.message);

}


interface IHttpResponse {
    status: boolean;
    message: string;
    result: any;
}


interface IAnalyticData {
    id: number;
    actualPath: string;
    url: string;
    createdAt: string;
    totalVisit: number;
    countries: string;
    raw_data: string;
    url_id: number;
}
