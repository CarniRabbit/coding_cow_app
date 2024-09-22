/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const path = require("path");
const serviceAccountPath = path.resolve(__dirname, "credentials",
    "dingca-976c1-firebase-adminsdk-aicqn-bf23eb77a1.json");
admin.initializeApp({
  credential: admin.credential.cert(require(serviceAccountPath)),
});

exports.resetAttendStatus = functions.pubsub.schedule(
    "every day 06:00").onRun(async (context) => {
  const usersRef = admin.firestore().collection("users");
  const snapshot = await usersRef.get();

  const batch = admin.firestore().batch();
  snapshot.forEach((doc) => {
    batch.update(doc.ref, {isAttend: false});
  });

  await batch.commit();
  console.log("reset complete");
});

exports.deleteUserByEmail = functions.https.onCall(async (data, context) => {
  const email = data.email;
  try {
    const userRecord = await admin.auth().getUserByEmail(email);
    await admin.auth().deleteUser(userRecord.uid);
    console.log("사용자 ${email}가 성공적으로 삭제되었습니다.");
    const userRef = admin.firestore().collection("users").doc(userRecord.uid);
    await userRef.delete();
    console.log("Firestore에서 사용자 데이터 삭제 완료: ${userRecord.uid}");
    return {success: true, message: "사용자 ${email} 삭제 완료"};
  } catch (error) {
    console.error("사용자 계정 삭제 중 오류 발생:", error);
    return {success: false, message: error.message};
  }
});

exports.resetTodayProblems = functions.pubsub.schedule("every day 06:00")
    .timeZone("Asia/Seoul")
    .onRun(async (context) => {
      const db = admin.firestore();
      try {
        const todayProblemsRef = db.collection("todayProblems");
        const snapshot = await todayProblemsRef.get();
        if (!snapshot.empty) {
          const batch = db.batch();
          snapshot.docs.forEach((doc) => {
            batch.delete(doc.ref);
          });
          await batch.commit();
          console.log("todayProblems 컬렉션이 초기화되었습니다.");
        } else {
          console.log("todayProblems 컬렉션이 비어있습니다.");
        }
      } catch (error) {
        console.error("오늘의 문제 초기화 중 오류가 발생했습니다:", error);
      }
      return null;
    });
