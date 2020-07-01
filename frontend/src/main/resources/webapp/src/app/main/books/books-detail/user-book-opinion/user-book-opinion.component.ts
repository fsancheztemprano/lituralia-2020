import {Component, ElementRef, OnInit, Renderer2, ViewChild} from '@angular/core';
import {UserOpinionService} from "../../../../shared/services/user-opinion.service";
import {ActivatedRoute} from "@angular/router";
import {DialogService, LoginService} from "ontimize-web-ngx";
import {Opinion} from "../../../opinions/opinion";

@Component({
  selector: 'app-user-book-opinion',
  templateUrl: './user-book-opinion.component.html',
  styleUrls: ['./user-book-opinion.component.scss']
})
export class UserBookOpinionComponent implements OnInit {


  @ViewChild("activeReview") aReview: ElementRef;
  @ViewChild("activeRating") aRating: ElementRef;

  user: string = "";

  opinion: Opinion = null;
  private book_id: number;

  public activeEditReview: string = ""
  public activeEditRating: number = 0

  editMode: boolean = false;


  constructor(private loginService: LoginService,
              private userOpinionService: UserOpinionService,
              private route: ActivatedRoute,
              private renderer: Renderer2,
              private dialogService: DialogService) {
  }


  ngOnInit() {
    this.user = this.loginService.getSessionInfo().user
    this.book_id = +this.route.snapshot.paramMap.get('book_id');
    this.getUserOpinion();
  }

  private getUserOpinion() {
    this.userOpinionService.getUserOpinion(this.user, +this.book_id).subscribe(value => {
      this.opinion = value.data[0]
      this.editMode = this.hasOpinion()
      if (this.editMode) {
        this.activeEditReview = this.opinion.review
        this.activeEditRating = this.opinion.rating
      } else {
        this.activeEditRating = 1
        this.activeEditReview = ""
      }
    })
  }

  isUpdated() {
    if (this.opinion === null)
      return false
    return typeof this.opinion.opinion_update !== 'undefined'
  }

  hasOpinion(): boolean {
    return this.opinion !== null && typeof this.opinion !== 'undefined'
  }

  updateOpinion() {
    const reviewElement: any = this.aReview
    const review: string = reviewElement.value.value
    const ratingElement: any = this.aRating
    const rating: string = ratingElement.value.value
    this.userOpinionService.updateUserOpinion(this.opinion.opinion_id, +rating, review)
    .subscribe(
      value => this.dialogService.info("Updating Opinion", "Update OK"),
      error => this.dialogService.error("Updating Opinion", "Update Error"),
      () => this.getUserOpinion()
    )
  }

  createOpinion() {
    const reviewElement: any = this.aReview
    const review: string = reviewElement.value.value
    const ratingElement: any = this.aRating
    const rating: string = ratingElement.value.value
    this.userOpinionService.createUserOpinion(this.loginService.getSessionInfo().user, this.book_id, +rating, review)
    .subscribe(
      value => this.dialogService.info("Creating Opinion", "Creation OK"),
      error => this.dialogService.error("Creating Opinion", "Creation Error"),
      () => this.getUserOpinion()
    )
  }

  deleteOpinion() {
    this.userOpinionService.deleteUserOpinion(this.opinion.opinion_id)
    .subscribe(
      value => this.dialogService.info("Deleting Opinion", "Removal OK"),
      error => this.dialogService.error("Deleting Opinion", "Removal Error"),
      () => this.getUserOpinion()
    )
  }


  getRatingValues() {
    const array: Array<Object> = [];
    array.push({
      'key': 0,
      'value': '0'
    });
    array.push({
      'key': 1,
      'value': '1'
    });
    array.push({
      'key': 2,
      'value': '2'
    });
    array.push({
      'key': 3,
      'value': '3'
    });
    array.push({
      'key': 4,
      'value': '4'
    });
    array.push({
      'key': 5,
      'value': '5'
    });
    return array;
  }
}
