import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

interface Student {
  name: string;
  enrollment: string;
  email: string;
  age: number | null;
}

@Component({
  selector: 'app-student-form',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './student-form.component.html',
  styleUrls: ['./student-form.component.css']
})
export class StudentFormComponent {
  studentName: string = '';
  enrollment: string = '';
  email: string = '';
  age: number | null = null;
  submitted: boolean = false;
  students: Student[] = [];

  submitForm() {
    if (
      this.studentName.length > 3 &&
      this.enrollment.length >= 5 &&
      this.email.includes('@')
    ) {
      this.students.push({
        name: this.studentName,
        enrollment: this.enrollment,
        email: this.email,
        age: this.age
      });
      this.submitted = true;
      this.studentName = '';
      this.enrollment = '';
      this.email = '';
      this.age = null;
      setTimeout(() => (this.submitted = false), 2000);
    } else {
      this.submitted = false;
    }
  }
}