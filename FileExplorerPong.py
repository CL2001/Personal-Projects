import threading
import keyboard
import time
import os
import random


#Var global
file_path = "C:/Users/chris/IdeaProjects/FileExplorerPong/Game"
c_gauche = 60
c_droite = 74
balle = 64



def rename_file(file_path, old_name, new_name):
    try:
        old_path = file_path + "/" + old_name
        new_path = file_path + "/" + new_name
        os.rename(old_path, new_path)
    except FileNotFoundError:
        print(f"File '{old_name}' not found.")
    except FileExistsError:
        print(f"File '{new_name}' already exists.")

def fichierExiste(file_path, file_name):
    return os.path.exists(file_path + "/" + file_name)




def resetJeu():
    gauche = 0
    while gauche <= 120:
        if fichierExiste(file_path, f"{gauche}.jpg"):
            break
        gauche += 15
    global c_gauche
    c_gauche = gauche
    while (gauche != 60):
        if gauche > 60:
            monteGauche()
            gauche -= 15
        if gauche < 60:
            descendGauche()
            gauche += 15
        time.sleep(0.5)

    droite = 14
    while droite <= 134:
        if fichierExiste(file_path, f"{droite}.jpg"):
            break
        droite += 15
    global  c_droite
    c_droite = droite
    while (droite != 74):
        if droite > 74:
            monteDroit()
            droite -= 15
        if droite < 74:
            descendDroit()
            droite += 15
        time.sleep(0.5)

    for i in range (150):
        if fichierExiste(file_path, f"{i}_ball.jpg") and i != 64:
            moveBall(i, 64)
            break



def monteGauche():
    global c_gauche
    if c_gauche > 0:
        rename_file(file_path, f"{c_gauche+15}.jpg", f"{c_gauche-15}.jpg")
        rename_file(file_path, f"{c_gauche-15}.txt", f"{c_gauche+15}.txt")
        c_gauche -= 15
        #keyboard.send('f5')# refresh file explorer


def descendGauche():
    global c_gauche
    if c_gauche < 120:
        rename_file(file_path, f"{c_gauche}.jpg", f"{c_gauche+30}.jpg")
        rename_file(file_path, f"{c_gauche+30}.txt", f"{c_gauche}.txt")
        c_gauche += 15
        #keyboard.send('f5')

def monteDroit():
    global c_droite
    if c_droite > 14:
        rename_file(file_path, f"{c_droite+15}.jpg", f"{c_droite-15}.jpg")
        rename_file(file_path, f"{c_droite-15}.txt", f"{c_droite+15}.txt")
        c_droite -= 15
        #keyboard.send('f5')

def descendDroit():
    global c_droite
    if c_droite < 134:
        rename_file(file_path, f"{c_droite}.jpg", f"{c_droite+30}.jpg")
        rename_file(file_path, f"{c_droite+30}.txt", f"{c_droite}.txt")
        c_droite += 15
        #keyboard.send('f5')

def trajectoire1d(current_pos, trajectoire):
    while current_pos not in (14, 29, 44, 59, 74, 89, 104, 119, 134, 149):
        current_pos -= 14
        trajectoire.append(current_pos)
        if 0 <= current_pos <= 14:
            current_pos, nouv_trajectoire = trajectoire5d(current_pos, trajectoire)
            trajectoire + nouv_trajectoire
    return current_pos, trajectoire

def trajectoire2d(current_pos, trajectoire):
    while current_pos not in (14, 29, 44, 59, 74, 89, 104, 119, 134, 149):
        if len(trajectoire) % 2 == 0:
            current_pos += 1
        else:
            current_pos -= 14
        trajectoire.append(current_pos)
        if 0 <= current_pos <= 14:
            current_pos, nouv_trajectoire = trajectoire4d(current_pos, trajectoire)
            trajectoire + nouv_trajectoire
    return current_pos, trajectoire

def trajectoire3d(current_pos, trajectoire):
    while current_pos not in (14, 29, 44, 59, 74, 89, 104, 119, 134, 149):
        current_pos += 1
        trajectoire.append(current_pos)
    return current_pos, trajectoire

def trajectoire4d(current_pos, trajectoire):
    while current_pos not in (14, 29, 44, 59, 74, 89, 104, 119, 134, 149):
        if len(trajectoire) % 2 == 0:
            current_pos += 1
        else:
            current_pos += 16
        trajectoire.append(current_pos)
        if 135 <= current_pos <= 149:
            current_pos, nouv_trajectoire = trajectoire2d(current_pos, trajectoire)
            trajectoire + nouv_trajectoire
    return current_pos, trajectoire

def trajectoire5d(current_pos, trajectoire):
    while current_pos not in (14, 29, 44, 59, 74, 89, 104, 119, 134, 149):
        current_pos += 16
        trajectoire.append(current_pos)
        if 135 <= current_pos <= 149:
            current_pos, nouv_trajectoire = trajectoire1d(current_pos, trajectoire)
            trajectoire + nouv_trajectoire
    return current_pos, trajectoire


#gauche
def trajectoire1g(current_pos, trajectoire):
    while current_pos not in (0, 15, 30, 45, 60, 75, 90, 105, 120, 135):
        current_pos -= 16
        trajectoire.append(current_pos)
        if 0 <= current_pos <= 14:
            current_pos, nouv_trajectoire = trajectoire5g(current_pos, trajectoire)
            trajectoire + nouv_trajectoire
    return current_pos, trajectoire

def trajectoire2g(current_pos, trajectoire):
    while current_pos not in (0, 15, 30, 45, 60, 75, 90, 105, 120, 135):
        if len(trajectoire) % 2 == 0:
            current_pos -= 1
        else:
            current_pos -= 16
        trajectoire.append(current_pos)
        if 0 <= current_pos <= 14:
            current_pos, nouv_trajectoire = trajectoire4g(current_pos, trajectoire)
            trajectoire + nouv_trajectoire
    return current_pos, trajectoire

def trajectoire3g(current_pos, trajectoire):
    while current_pos not in (0, 15, 30, 45, 60, 75, 90, 105, 120, 135):
        current_pos -= 1
        trajectoire.append(current_pos)
    return current_pos, trajectoire

def trajectoire4g(current_pos, trajectoire):
    while current_pos not in (0, 15, 30, 45, 60, 75, 90, 105, 120, 135):
        if len(trajectoire) % 2 == 0:
            current_pos -= 1
        else:
            current_pos += 14
        trajectoire.append(current_pos)
        if 135 <= current_pos <= 149:
            current_pos, nouv_trajectoire = trajectoire2g(current_pos, trajectoire)
            trajectoire + nouv_trajectoire
    return current_pos, trajectoire

def trajectoire5g(current_pos, trajectoire):
    while current_pos not in (0, 15, 30, 45, 60, 75, 90, 105, 120, 135):
        current_pos += 14
        trajectoire.append(current_pos)
        if 135 <= current_pos <= 149:
            current_pos, nouv_trajectoire = trajectoire1g(current_pos, trajectoire)
            trajectoire + nouv_trajectoire
    return current_pos, trajectoire

def choisiTrajectoire(balle_pos, directrion, trajectoire):
    trajectoirenum = random.randint(1, 5)
    current_pos = balle_pos
    if trajectoirenum == 1 and directrion == "d":
        trajectoire1d(current_pos, trajectoire)
    if trajectoirenum == 2 and directrion == "d":
        trajectoire2d(current_pos, trajectoire)
    if trajectoirenum == 3 and directrion == "d":
        trajectoire3d(current_pos, trajectoire)
    if trajectoirenum == 4 and directrion == "d":
        trajectoire4d(current_pos, trajectoire)
    if trajectoirenum == 5 and directrion == "d":
        trajectoire5d(current_pos, trajectoire)
    if trajectoirenum == 1 and directrion == "g":
        trajectoire1g(current_pos, trajectoire)
    if trajectoirenum == 2 and directrion == "g":
        trajectoire2g(current_pos, trajectoire)
    if trajectoirenum == 3 and directrion == "g":
        trajectoire3g(current_pos, trajectoire)
    if trajectoirenum == 4 and directrion == "g":
        trajectoire4g(current_pos, trajectoire)
    if trajectoirenum == 5 and directrion == "g":
        trajectoire5g(current_pos, trajectoire)
    return trajectoire




def moveBall(current_pos, next_pos):
    rename_file(file_path, f"{current_pos}_ball.jpg", f"{next_pos}_ball.jpg")
    rename_file(file_path, f"{next_pos}.txt", f"{current_pos}.txt")
    global balle
    balle = next_pos
    keyboard.send('f5')

def control_ball():
    direction = "d"
    trajectoire = []
    choisiTrajectoire(balle, direction, trajectoire)
    i = 0
    while i < len(trajectoire):
        if fichierExiste(file_path, f"{trajectoire[i]}.jpg"):
            trajectoire.pop()
            if direction == "d":
                direction = "g"
            else:
                direction = "d"
            choisiTrajectoire(balle, direction, trajectoire)
        moveBall(balle, trajectoire[i])
        i += 1
        time.sleep(1)

"""
r: reset le jeu
w/s pour monter et descendre les colomnes de gauche
fleche haut et bas pour monter et descendre les colomnes de doites
"""
def on_key_pressed(event):
    if event.name == "w":
        monteGauche()
    elif event.name == "s":
        descendGauche()
    elif event.name == "haut":
        monteDroit()
    elif event.name == "bas":
        descendDroit()
    elif event.name == "r":
        resetJeu()
        time.sleep(3)
        game_thread = threading.Thread(target=control_ball)
        game_thread.start()

def main():
    keyboard.on_press(on_key_pressed)
    input("Press Enter to stop...\n")


if __name__ == "__main__":
    main()
