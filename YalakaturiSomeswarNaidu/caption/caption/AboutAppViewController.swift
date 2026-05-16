//
//  AboutAppViewController.swift
//  caption
//

import UIKit
import WebKit

class AboutAppViewController: UIViewController {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "About App"

        setupWebView()

        loadWebsite()
    }

    func setupWebView() {

        webView = WKWebView(
            frame: view.bounds
        )

        webView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]

        view.addSubview(webView)
    }

    func loadWebsite() {

        let html = """

        <!DOCTYPE html>
        <html>

        <head>

        <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

        <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:-apple-system;
        }

        body{

            background:
            linear-gradient(
            135deg,
            #0f0c29,
            #302b63,
            #24243e
            );

            color:white;

            padding:24px;

            overflow-x:hidden;
        }

        .hero{

            background:
            rgba(255,255,255,0.08);

            border-radius:32px;

            padding:32px;

            text-align:center;

            backdrop-filter:blur(25px);

            border:
            1px solid rgba(255,255,255,0.08);

            box-shadow:
            0 10px 40px rgba(0,0,0,0.4);

            animation:fade 1s ease;
        }

        @keyframes fade{

            from{
                opacity:0;
                transform:translateY(30px);
            }

            to{
                opacity:1;
                transform:translateY(0);
            }
        }

        .logo{

            width:120px;
            height:120px;

            border-radius:35px;

            margin:auto;

            display:flex;

            justify-content:center;
            align-items:center;

            font-size:55px;

            background:
            linear-gradient(
            135deg,
            #ff0057,
            #8f00ff
            );

            margin-bottom:24px;

            box-shadow:
            0 15px 35px rgba(255,0,87,0.4);
        }

        h1{

            font-size:38px;

            margin-bottom:12px;
        }

        .tagline{

            color:#d6d6d6;

            line-height:28px;

            font-size:17px;
        }

        .section{

            margin-top:35px;
        }

        .section-title{

            font-size:26px;

            margin-bottom:18px;

            font-weight:bold;
        }

        .card{

            background:
            rgba(255,255,255,0.07);

            border-radius:24px;

            padding:24px;

            margin-bottom:18px;

            border:
            1px solid rgba(255,255,255,0.08);

            backdrop-filter:blur(20px);

            transition:0.3s;
        }

        .card:hover{

            transform:scale(1.02);
        }

        .feature{

            font-size:21px;

            font-weight:700;

            margin-bottom:10px;
        }

        .desc{

            color:#d8d8d8;

            line-height:26px;

            font-size:16px;
        }

        .developer{

            text-align:center;
        }

        .footer{

            margin-top:40px;

            text-align:center;

            color:#bbbbbb;

            padding-bottom:40px;
        }

        .version{

            margin-top:18px;

            display:inline-block;

            padding:12px 24px;

            border-radius:30px;

            background:
            linear-gradient(
            135deg,
            #ff0057,
            #8f00ff
            );

            font-weight:bold;
        }

        </style>

        </head>

        <body>

        <div class="hero">

        <div class="logo">
                √
        </div>

        <h1>Caption Kanban</h1>

        <p class="tagline">

        A premium productivity and collaboration platform
        designed to organize tasks, boards, workflows,
        realtime teamwork, and smart project management.

        </p>

        </div>


        <div class="section">

        <div class="section-title">
        Features
        </div>

        <div class="card">

        <div class="feature">
        Smart Boards
        </div>

        <div class="desc">

        Create and manage beautiful workflow boards with
        advanced organization and realtime syncing.

        </div>

        </div>

        <div class="card">

        <div class="feature">
        Firebase Integration
        </div>

        <div class="desc">

        Fast and secure cloud-powered experience using
        Firebase Authentication and Firestore database.

        </div>

        </div>

        <div class="card">

        <div class="feature">
        Elegant UI Experience
        </div>

        <div class="desc">

        Premium dark-mode interface inspired by modern
        SaaS and productivity applications.

        </div>

        </div>

        </div>


        <div class="section">

        <div class="section-title">
        Developer
        </div>

        <div class="card developer">

        <h2>
        YALAKATURI SOMESWARNAIDU
        </h2>

        <br>

        <p class="desc">

        Passionate iOS developer focused on building
        scalable applications using Swift, Firebase,
        AI tools, and modern UI/UX systems.

        </p>

        </div>

        </div>


        <div class="footer">

        Made with using Swift & Firebase

        <div class="version">
        Version 1.0.0
        </div>

        </div>

        </body>
        </html>

        """

        webView.loadHTMLString(
            html,
            baseURL: nil
        )
    }
}
