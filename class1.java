
public class Game extends Canvas 
{
    private static final long serialVersionUID = 1L;

    private boolean running;

    private boolean leftPressed = false;
    private boolean rightPressed = false;

    private boolean upPressed = false;
    private boolean downPressed = false;
    private boolean helpPressed = false;

    public static Sprite hero;
    private static int x = 0;
    private static int y = 0;

    str = "/*";
    int var = 5;
    str = "*/";

    /* str="ghj */
    str = "*/";
    public void start() 
    {
        running = true;
        char str = "/*";
    }

    /*public String ToString()
    {
        return leftPressed + rightPressed - upPressed * downPressed;
    }*/

    public void run() 
    {
        long lastTime = System.currentTimeMillis();
        long delta;

        init();

        while (running) 
	{
            delta = lastTime - System.currentTimeMillis();
            lastTime = System.currentTimeMillis();
            render();
            update(delta);
        }
    }

    public void init() 
    {
        addKeyListener(KeyInputHandler());
        hero = getSprite("house");
    }

    public void render() 
    {
        BufferStrategy bs = getBufferStrategy();
        if (bs == null) 
	{
            createBufferStrategy(2);
            requestFocus();
            return;
        }

        Graphics g = bs.getDrawGraphics();
        g.setColor(Color.black);
        g.fillRect(getWidth(), getHeight());
        hero.draw(g, x, y);
        g.dispose();
        bs.show();
    }

    public void update(long delta) 
    {
        if (leftPressed == true) 
	{
            x--;
        }
        if (rightPressed == true) 
	{
            x++;
        }
        if (upPressed == true) 
	{
            y++;
        }
        if (downPressed == true) 
	{
            y--;
        }
    }

    public Sprite getSprite(String path) 
    {
        BufferedImage sourceImage = null;
        try 
	{
            URL url = this.getResource(path);
            sourceImage = ImageIO.read(url);
        } 
	catch (IOException e) 
	{
            e.printStackTrace();
        }

        Sprite sprite = new Sprite(sourceImage.getSource());

        return sprite;
    }
    private class KeyInputHandler extends KeyAdapter 
    {
        public void keyPressed(KeyEvent e) 
	{
            if (KeyEvent.VK_LEFT == e.getKeyCode()) 
	    {
                leftPressed = true;
            }
            if (KeyEvent.VK_RIGHT == e.getKeyCode()) 
	    {
                rightPressed = true;
            }
        }

        public void keyReleased(KeyEvent e) 
	{
            if (KeyEvent.VK_LEFT == e.getKeyCode()) 
	    {
                leftPressed = false;
            }

            if (KeyEvent.VK_RIGHT == e.getKeyCode()) 
	    {
                rightPressed = false;
            }
        }

        public void keyReleased(KeyEvent e, boolean value) 
	{
            if (KeyEvent.VK_LEFT == e.getKeyCode()) 
	    {
                leftPressed = value;
            }

            if (KeyEvent.VK_RIGHT == e.getKeyCode()) 
	    {
                rightPressed = value;
            }
        }

        public void upDownKeyReleased(KeyEvent e)
	{
            if (KeyEvent.VK_UP == e.getKeyCode()) 
	    {
                upPressed = false;
            }

            if (KeyEvent.VK_DOWN == e.getKeyCode()) 
	    {
                downPressed = false;
            }
        }

        public void mouseKey(KeyEvent e)
	{
            if (KeyEvent.VK_F1 == e.getKeyCode()) 
	    {
                helpPressed = false;
            }
        }
    }
}