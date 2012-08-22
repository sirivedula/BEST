using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;

namespace BaliEnterpriseSystems
{
    public static class UtilExporter
    {

        public static string StudentSQL()
        {
            StringBuilder studentSQL = new StringBuilder();
            studentSQL.Append(@"select convert(varchar(10),BestStudentGPA.assessmentDate,101) as assessmentDate , BestStudentGPA.assessmentGPA , BestStudentGPA.assessmentLevel , convert(varchar(10),BestStudentNotes.noteDate,101) as noteDate , BestStudentNotes.notes , BestStudentPayment.parentemail , BestStudentPayment.name , BestStudentPayment.paymethod , BestStudentPickup.contactName , BestStudentPickup.contactPhone , BestStudentPickup.relationship , BestStudentPicture.hobbies , BestStudentPicture.personality , BestStudentPicture.goals , BestStudentPicture.learningstyle , BestStudentPicture.tutorpreference , BestStudentPrograms.amount , BestStudentReference.referencedby , BestStudentReference.expectedDuration , BestStudentReference.blcRecommend , BestStudentReference.proposedProg , BestStudentReference.proposedHour , BestStudentReference.parentComments , BestStudentReference.parentExpects , BestStudentReference.emergName , BestStudentReference.emergPhone , BestStudentReference.healthConditions , BestStudents.CenterId , BestStudents.StudentId , BestStudents.firstName , BestStudents.lastName , BestStudents.middleName , BestStudents.parentName , BestStudents.address1 , BestStudents.address2 , BestStudents.city , BestStudents.state , BestStudents.zip , BestStudents.cellPhone , BestStudents.homePhone , BestStudents.workPhone , BestStudents.emailId , BestStudents.gender , BestStudents.hours , BestStudentPrograms.programGuid , BestStudents.hourType , BestStudents.amountType as studentAmtType , convert(varchar(10),BestStudents.joinDate,101) as joinDate , convert(varchar(10),BestStudents.birthDate,101) as birthDate , BestStudents.guardianName , BestStudents.school , BestStudents.grade, (select programname from bestprograms where guidfield = beststudentprograms.programguid) as programName,(select programType from bestprograms where guidfield = beststudentprograms.programguid) as programType,(select amount from bestprograms where guidfield = beststudentprograms.programguid) as programAmount, (select amounttype from bestprograms where guidfield = beststudentprograms.programguid) as amountType
from BestStudents
Left Join BestStudentGPA On BestStudentGPA.studentguid = BestStudents.guidfield
Left Join BestStudentNotes On BestStudentNotes.studentguid = BestStudents.guidfield
Left Join BestStudentPickup On BestStudentPickup.studentguid = BestStudents.guidfield
Left Join BestStudentPayment On BestStudentPayment.studentguid = BestStudents.guidfield
Left Join BestStudentReference On BestStudentReference.studentguid = BestStudents.guidfield
Left Join BestStudentPicture On BestStudentPicture.studentguid = BestStudents.guidfield
Left Join BestStudentPrograms On BestStudentPrograms.studentguid = BestStudents.guidfield
");

            return studentSQL.ToString();
        }

        public static string TutorSQL()
        {
            StringBuilder tutorSQL = new StringBuilder();
            tutorSQL.AppendLine("Select BestTutors.TutorId  , BestTutors.firstName  , BestTutors.lastName  , BestTutors.middleName  , BestTutors.address1  , BestTutors.address2  , BestTutors.city  , BestTutors.state  , BestTutors.zip  , BestTutors.cellPhone  , BestTutors.homePhone  , BestTutors.workPhone  , BestTutors.emailId  , BestTutors.gender  , convert(varchar(10), BestTutors.joinDate,101) as joinDate  , BestTutors.school  , BestTutors.yearGraduated  , BestTutors.GPA  , BestTutors.Major  , BestTutors.Expertise  , BestTutors.learningStyle  , BestTutors.matchup  , BestTutors.gradeLevels  , BestTutors.otherSkill  , BestTutors.programStyle  , BestTutors.salary  , BestTutors.perhour  , BestTutors.CenterId From BestTutors");

            return tutorSQL.ToString();
        }

        public static string PaymentSQL()
        {
            StringBuilder paymentSQL = new StringBuilder();
            paymentSQL.AppendLine("Select convert(varchar(10),BestPaymentDetails.paymentDate,101) as paymentDate, BestPaymentDetails.amount, BestPaymentDetails.hours, BestPaymentTypes.paymentType, BestStudents.studentId, BestStudents.centerId From BestPaymentDetails inner join BestStudents on BestStudents.guidfield = BestPaymentDetails.studentGuid left join BestPaymentTypes on BestPaymentTypes.guidfield = BestPaymentDetails.paymentTypeGuid");

            return paymentSQL.ToString();
        }

        public static string ScheduleSQL()
        {
            StringBuilder scheduleSQL = new StringBuilder();
            scheduleSQL.AppendLine("Select Convert(varchar(10),BestSchedules.schDate,101) as SchDate, BestSchedules.schFrom as FromTime, BestSchedules.schTo as ToTime, BestSchedules.isDeleted as deleted,BestSchedules.attended1 as Attended1, BestSchedules.attended2 as Attended2, BestSchedules.attended3 as Attended3, BestSchedules.attended4 as Attended4, BestSchedules.attended5 as Attended5, BestSchedules.note1 as Notes1, BestSchedules.note2 as Notes2, BestSchedules.note3 as Notes3, BestSchedules.note4 as Notes4, BestSchedules.note5 as Notes5, BestSchedules.amount1 as Amount1, BestSchedules.amount2 as Amount2, BestSchedules.amount3 as Amount3, BestSchedules.amount4 as Amount4, BestSchedules.amount5 as Amount5, (select firstname + ' ' + lastname from BestStudents where BestStudents.guidfield = BestSchedules.stuGuid1) as Student1, (select firstname + ' ' + lastname from BestStudents where BestStudents.guidfield = BestSchedules.stuGuid2) as Student2, (select firstname + ' ' + lastname from BestStudents where BestStudents.guidfield = BestSchedules.stuGuid3) as Student3, (select firstname + ' ' + lastname from BestStudents where BestStudents.guidfield = BestSchedules.stuGuid4) as Student4, (select firstname + ' ' + lastname from BestStudents where BestStudents.guidfield = BestSchedules.stuGuid5) as Student5,(Select firstname + ' ' + lastname from BestTutors where BestTutors.guidfield = BestSchedules.tutGuid) as Tutor, (select programDesc from VBestPrograms where VBestPrograms.guidfield=BestSchedules.progGuid1) as Program1, (select programDesc from VBestPrograms where VBestPrograms.guidfield=BestSchedules.progGuid2) as Program2, (select programDesc from VBestPrograms where VBestPrograms.guidfield=BestSchedules.progGuid3) as Program3, (select programDesc from VBestPrograms where VBestPrograms.guidfield=BestSchedules.progGuid4) as Program4, (select programDesc from VBestPrograms where VBestPrograms.guidfield=BestSchedules.progGuid5) as Program5, BestSchedules.tutorattend from BestSchedules ");

            return scheduleSQL.ToString();
        }

        public static string ChangeAuditSQL()
        {
            StringBuilder changeAuditSQL = new StringBuilder();
            changeAuditSQL.AppendLine("select tablename,fieldname,oldvalue,newvalue,changedate,changedby,centerid,studentid from logchanges order by changedate desc");

            return changeAuditSQL.ToString();
        }

    }
}
