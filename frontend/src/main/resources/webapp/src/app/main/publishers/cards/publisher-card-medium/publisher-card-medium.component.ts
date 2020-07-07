import {Component, Input, OnInit} from '@angular/core';
import {Publisher} from "../../publisher";

@Component({
  selector: 'app-book-card-medium',
  templateUrl: './publisher-card-medium.component.html',
  styleUrls: ['./publisher-card-medium.component.scss']
})
export class PublisherCardMediumComponent implements OnInit {

  @Input() publisher: Publisher
  
  constructor() { }

  ngOnInit() {
  }
  
  getImageSrc(logo: any) {
    return 'data:image/png;base64,' + logo;
  }

  addToMyList(publisher_id: number) {

  }

  reviewPopup(publisher_id: number) {

  }
}
