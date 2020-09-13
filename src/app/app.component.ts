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

    constructor(private httpClient: HttpClient) {
    }


    public generateUrl(actualPath: string): void {
        this.generatedUrl = null;
        this.httpClient.post(environment.apiUrl + 'getUrl', {url: actualPath}) .subscribe( this.displayShortUrl, this.handleError );
    }


    private displayShortUrl = (httpResponse: IHttpResponse): void => {
        this.generatedUrl = environment.apiUrl + httpResponse.result[0].url;
        this.url = null;
    }


    private handleError = (err) =>  window.alert(err.message);

}


interface IHttpResponse {
    status: boolean;
    message: string;
    result: any;
}
