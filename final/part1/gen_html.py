from itertools import product
from functools import reduce

def get_heading():
    heading='''
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="utf-8">
        <title>Image list prediction</title>
      <style type="text/css">
       img {
         width:200px;
       }
      </style>
      </head>
      <body>
      <h2>Gongze Cao, Zhenyu Gao, Kai Liang, Vincent Wen</h2>  
    '''
    return heading

def get_sign():
    sign='''
    <h2>Gongze Cao, Zhenyu Gao, Kai Liang, Vincent Wen</h2>   
    '''
    return sign

def get_setting(setting_li):
    setting_temp = '''
        <h1>Settings</h1>
        <table>
        <tr><th>SIFT step size</th><td>5 px</td></tr>
        <tr><th>SIFT sample method</th><td>{}</td></tr>
        <tr><th>Vocabulary size</th><td>{} words</td></tr>
        <tr><th>color space</th><td>{}</td></tr>
        <tr><th>Vocabulary fraction</th><td>0.2</td></tr>
        <tr><th>SVM training data</th><td>400 positive, 1600 negative per class</td></tr>
        <tr><th>SVM kernel type</th><td>RBF</td></tr>
    '''.format(*setting_li)
    return setting_temp

def get_table(map, APs, images_front, images_end):
    stats= [map]+APs+images_front+APs+images_end
    # print((stats))
    table_temp = '''
    </table>
    <h1>Prediction lists (MAP: {})</h1>

    Positive Order

    <table>
    <thead>
    <tr>
    <th>Airplanes (AP: {})</th><th>Birds (AP: {})</th><th>Ships (AP: {})</th><th>Horses (AP: {})</th><th>Cars (AP: {})</th>
    </tr>
    </thead>
    
    <tbody>
    <tr><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td></tr>
    <tr><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td></tr>
    <tr><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td></tr>
    <tr><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td></tr>
    <tr><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td></tr>
    </tbody>
    </table>
    
    Reverse order
    
    <table>
    <thead>
    <tr>
    <th>Airplanes (AP: {})</th><th>Birds (AP: {})</th><th>Ships (AP: {})</th><th>Horses (AP: {})</th><th>Cars (AP: {})</th>
    </tr>
    </thead>

    <tbody>
    <tr><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td></tr>
    <tr><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td></tr>
    <tr><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td></tr>
    <tr><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td></tr>
    <tr><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td><td><img src="{}" /></td></tr>
    </tbody>
    </table>
    '''.format(*stats)
    return table_temp

def close_html(inside):
    return inside+"\n  </body>\n </html>"

def read_log(file_name):
    with open(file_name, 'r') as f:
        content = f.readlines()
        mAP = float(content[0])
        APs = [float(a) for a in content[2:]]
    return mAP, APs

def get_images_dir(params, is_front='front'):
    gen_dir = lambda j: [
        './images/{}_{}_{}_img_class_{}_{}_{}.png'.format(*params, i, is_front, j) for i in range(1,6)]
    pre_res = [gen_dir(j) for j in range(1,6)]
    res = reduce(lambda x,y: x+y, pre_res)
    return list(res)

def main():
    feature_size=(400, 1000, 4000)
    sample_method = ('key', 'dense')
    colorspace = ('grey', 'rgb', 'orgb')
    base = get_heading()
    for fs, sm, cs in product(sample_method, feature_size, colorspace):
        base += get_setting([fs, sm, cs])
        # print(fs, sm, cs)
        log_name = './log/{}_{}_{}_log.txt'.format(sm, fs, cs)
        mAP, APs = read_log(log_name)
        imgs_front = get_images_dir([sm, fs, cs], 'front')
        imgs_end = get_images_dir([sm, fs, cs], 'end')
        base+=get_table(mAP, APs, imgs_front, imgs_end)
    s = close_html(base)
    with open('output.html', 'w') as f:
        print(s, file=f)
    



if __name__ == "__main__":
    main()
