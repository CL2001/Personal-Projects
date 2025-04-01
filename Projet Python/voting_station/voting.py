import time
import test_finger
import test_rfid
import test_screen
import test_bouton
import test_database
from multiprocessing import Process, freeze_support
import RPi.GPIO as GPIO


def voting_message():
    candidates = test_database.get_candidates()
    test_screen.clear_lcd()
    time.sleep(0.5)
    msg_a = "A " + str(candidates[0])
    msg_b = "B " + str(candidates[1])
    msg_c = "C " + str(candidates[2])
    msg_d = "D " + str(candidates[3])
    while True:
        test_screen.write_lcd(msg_a, msg_b)
        time.sleep(1.5)
        test_screen.write_lcd(msg_c, msg_d)
        time.sleep(1.5)




#Start loop here
while True:
    try:
        test_screen.write_lcd("Voter(A)", "Enregistrer(B)")
        time.sleep(1)
        choix = test_bouton.get_vote()

        if choix == "A":
            test_screen.write_lcd("Vous pouvez", "maintenant voter")
            time.sleep(1)
            finger_id = test_finger.get_fingerprint()
            print("finger_id", finger_id)
            if finger_id is not None:
                if not test_database.vote_already_exists(finger_id):
                    freeze_support()
                    p = Process(target=voting_message)
                    p.start()
                    time.sleep(2)
                    vote = test_bouton.get_vote()
                    vote_lower = vote.lower()
                    p.terminate()
                    p.join()
                    time.sleep(0.5)
                    str_msg = "pour " + str(vote) + " ajouter"
                    test_screen.write_lcd("Merci. Vote", str_msg)
                    test_database.add_vote(finger_id, vote_lower)

                else:
                    test_screen.write_lcd("Vous avez", "deja voter")
            else:
                test_screen.write_lcd("Enregistrer vous", "pour voter")


        elif choix == "B":
            test_screen.write_lcd("Scanner votre", "carte etudiante")
            time.sleep(1)
            GPIO.cleanup()
            card_id = test_rfid.main()
            time.sleep(1)
            test_screen.init_lcd()
            test_bouton.init_vote()
            if not test_database.user_already_exists(card_id):
                finger_id = test_finger.enroll_finger()
                test_screen.write_lcd("Enregistrer", "Vous pouvez voter")
                test_database.add_user(finger_id, card_id)
            else:
                test_screen.write_lcd("Deja enregistrer", "svp voter")



        time.sleep(3)
        test_screen.clear_lcd()
        time.sleep(1)
    except KeyboardInterrupt:
        test_screen.clear_lcd()
        time.sleep(0.1)
        GPIO.cleanup()
        print("stopping")  
        break  




